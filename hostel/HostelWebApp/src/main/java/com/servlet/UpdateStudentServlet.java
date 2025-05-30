// UpdateStudentServlet.java
package com.servlet;

import com.dao.HostelDAO;
import com.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/update")
public class UpdateStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private HostelDAO hostelDAO;
    
    public void init() {
        hostelDAO = new HostelDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get the student ID from request parameter
            int id = Integer.parseInt(request.getParameter("id"));
            
            // Fetch the student from database
            Student existingStudent = hostelDAO.selectStudent(id);
            
            // Check if student exists
            if (existingStudent != null) {
                // Set student as request attribute and forward to update form
                request.setAttribute("student", existingStudent);
                request.getRequestDispatcher("studentupdate.jsp").forward(request, response);
            } else {
                // Student not found - handle error
                request.setAttribute("error", "Student with ID " + id + " not found.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            // Invalid ID format
            request.setAttribute("error", "Invalid student ID format: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            // Other errors
            request.setAttribute("error", "Error retrieving student: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Validate and parse form data
            int studentID = validateStudentID(request.getParameter("studentID"));
            String studentName = validateStudentName(request.getParameter("studentName"));
            String roomNumber = validateRoomNumber(request.getParameter("roomNumber"));
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date admissionDate = validateDate(request.getParameter("admissionDate"), sdf);
            
            double feesPaid = validateFees(request.getParameter("feesPaid"));
            double pendingFees = validateFees(request.getParameter("pendingFees"));
            
            // Create updated student object
            Student updatedStudent = new Student(studentID, studentName, roomNumber, 
                                               admissionDate, feesPaid, pendingFees);
            
            // Update student in database
            boolean success = hostelDAO.updateStudent(updatedStudent);
            
            if (success) {
                // Set success message in session for display after redirect
                request.getSession().setAttribute("success", "Student updated successfully!");
                // Redirect to student list
                response.sendRedirect(request.getContextPath() + "/list");
            } else {
                // Update failed - return to form with error
                request.setAttribute("error", "Failed to update student. Please try again.");
                request.setAttribute("student", updatedStudent);
                request.getRequestDispatcher("studentupdate.jsp").forward(request, response);
            }
            
        } catch (ValidationException e) {
            // Validation errors - return to form with error message
            request.setAttribute("error", e.getMessage());
            
            try {
                // Recreate student object from form data for form repopulation
                int studentID = Integer.parseInt(request.getParameter("studentID"));
                Student student = hostelDAO.selectStudent(studentID);
                request.setAttribute("student", student);
            } catch (Exception ex) {
                // If can't retrieve student, create a new one with form data
                try {
                    int studentID = Integer.parseInt(request.getParameter("studentID"));
                    String studentName = request.getParameter("studentName");
                    String roomNumber = request.getParameter("roomNumber");
                    
                    Student student = new Student();
                    student.setStudentID(studentID);
                    student.setStudentName(studentName);
                    student.setRoomNumber(roomNumber);
                    
                    // Don't worry about parsing dates or numbers for repopulation
                    request.setAttribute("student", student);
                } catch (Exception e2) {
                    // If all else fails, just show the error
                }
            }
            
            request.getRequestDispatcher("studentupdate.jsp").forward(request, response);
            
        } catch (SQLException e) {
            // Database errors
            request.setAttribute("error", "Database error: " + e.getMessage());
            
            try {
                int studentID = Integer.parseInt(request.getParameter("studentID"));
                Student student = hostelDAO.selectStudent(studentID);
                request.setAttribute("student", student);
            } catch (Exception ex) {
                // If can't retrieve student, just show the error
            }
            
            request.getRequestDispatcher("studentupdate.jsp").forward(request, response);
            
        } catch (Exception e) {
            // Other unexpected errors
            request.setAttribute("error", "Unexpected error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    // Validation helper methods
    
    private int validateStudentID(String idStr) throws ValidationException {
        try {
            int id = Integer.parseInt(idStr);
            if (id <= 0) {
                throw new ValidationException("Student ID must be a positive number.");
            }
            return id;
        } catch (NumberFormatException e) {
            throw new ValidationException("Invalid Student ID format. Please enter a valid number.");
        }
    }
    
    private String validateStudentName(String name) throws ValidationException {
        if (name == null || name.trim().isEmpty()) {
            throw new ValidationException("Student name cannot be empty.");
        }
        if (name.trim().length() < 2) {
            throw new ValidationException("Student name must be at least 2 characters long.");
        }
        return name.trim();
    }
    
    private String validateRoomNumber(String roomNumber) throws ValidationException {
        if (roomNumber == null || roomNumber.trim().isEmpty()) {
            throw new ValidationException("Room number cannot be empty.");
        }
        return roomNumber.trim();
    }
    
    private Date validateDate(String dateStr, SimpleDateFormat sdf) throws ValidationException {
        try {
            if (dateStr == null || dateStr.trim().isEmpty()) {
                throw new ValidationException("Admission date cannot be empty.");
            }
            Date date = sdf.parse(dateStr);
            
            // Optional: Check if date is in the future
            if (date.after(new Date())) {
                throw new ValidationException("Admission date cannot be in the future.");
            }
            
            return date;
        } catch (ParseException e) {
            throw new ValidationException("Invalid date format. Please use YYYY-MM-DD format.");
        }
    }
    
    private double validateFees(String feesStr) throws ValidationException {
        try {
            double fees = Double.parseDouble(feesStr);
            if (fees < 0) {
                throw new ValidationException("Fees cannot be negative.");
            }
            return fees;
        } catch (NumberFormatException e) {
            throw new ValidationException("Invalid fee format. Please enter a valid number.");
        }
    }
    
    // Custom exception for validation errors
    private class ValidationException extends Exception {
        private static final long serialVersionUID = 1L;
        
        public ValidationException(String message) {
            super(message);
        }
    }
}
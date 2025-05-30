// DisplayStudentsServlet.java
package com.servlet;

import com.dao.HostelDAO;
import com.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet({"/list", "/view"})
public class DisplayStudentsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private HostelDAO hostelDAO;
    
    public void init() {
        hostelDAO = new HostelDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        try {
            switch (action) {
                case "list":
                    listStudents(request, response);
                    break;
                case "view":
                    viewStudent(request, response);
                    break;
                default:
                    listStudents(request, response);
                    break;
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error displaying students: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    private void listStudents(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get success message if any (e.g., after successful add, update, or delete)
        String successMessage = (String) request.getSession().getAttribute("success");
        if (successMessage != null) {
            request.setAttribute("success", successMessage);
            request.getSession().removeAttribute("success"); // Clear after use
        }
        
        // Get all students from database
        List<Student> students = hostelDAO.selectAllStudents();
        request.setAttribute("students", students);
        
        // Calculate some statistics for dashboard (optional)
        int totalStudents = students.size();
        double totalPendingFees = 0;
        int studentsWithPendingFees = 0;
        
        for (Student student : students) {
            if (student.getPendingFees() > 0) {
                studentsWithPendingFees++;
                totalPendingFees += student.getPendingFees();
            }
        }
        
        request.setAttribute("totalStudents", totalStudents);
        request.setAttribute("studentsWithPendingFees", studentsWithPendingFees);
        request.setAttribute("totalPendingFees", totalPendingFees);
        
        // Forward to the student list JSP
        request.getRequestDispatcher("studentdisplay.jsp").forward(request, response);
    }
    
    private void viewStudent(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get student ID from request parameter
        int id = Integer.parseInt(request.getParameter("id"));
        
        // Get student from database
        Student student = hostelDAO.selectStudent(id);
        
        // Check if student exists
        if (student != null) {
            request.setAttribute("student", student);
            request.getRequestDispatcher("student-details.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Student with ID " + id + " not found.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
// AddStudentServlet.java
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

@WebServlet("/add")
public class AddStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private HostelDAO hostelDAO;
    
    public void init() {
        hostelDAO = new HostelDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get form data
            int studentID = Integer.parseInt(request.getParameter("studentID"));
            String studentName = request.getParameter("studentName");
            String roomNumber = request.getParameter("roomNumber");
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date admissionDate = sdf.parse(request.getParameter("admissionDate"));
            
            double feesPaid = Double.parseDouble(request.getParameter("feesPaid"));
            double pendingFees = Double.parseDouble(request.getParameter("pendingFees"));
            
            // Create new student object
            Student newStudent = new Student(studentID, studentName, roomNumber, admissionDate, feesPaid, pendingFees);
            
            // Add student to database
            hostelDAO.insertStudent(newStudent);
            
            // Redirect to student list
            response.sendRedirect("list");
            
        } catch (SQLException | ParseException e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("studentadd.jsp").forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("studentadd.jsp").forward(request, response);
    }
}
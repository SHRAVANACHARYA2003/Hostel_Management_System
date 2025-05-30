// DeleteStudentServlet.java
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

@WebServlet("/delete")
public class DeleteStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private HostelDAO hostelDAO;
    
    public void init() {
        hostelDAO = new HostelDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String confirm = request.getParameter("confirm");
        
        if ("yes".equals(confirm)) {
            try {
                // Delete the student if confirmation is provided
                hostelDAO.deleteStudent(id);
                request.setAttribute("success", "Student deleted successfully!");
                response.sendRedirect(request.getContextPath() + "/list");
            } catch (SQLException e) {
                request.setAttribute("error", "Error deleting student: " + e.getMessage());
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } else {
            // Show confirmation page
            Student student = hostelDAO.selectStudent(id);
            if (student != null) {
                request.setAttribute("student", student);
                request.getRequestDispatcher("studentdelete.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Student with ID " + id + " not found.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
// ReportServlet.java
package com.servlet;

import com.dao.HostelDAO;
import com.model.Student;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/reports")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private HostelDAO hostelDAO;
    
    public void init() {
        hostelDAO = new HostelDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            // Show reports menu
            request.getRequestDispatcher("reports.jsp").forward(request, response);
            return;
        }
        
        switch (action) {
            case "pending-fees":
                pendingFeesReport(request, response);
                break;
            case "room-wise":
                roomForm(request, response);
                break;
            case "date-range":
                dateRangeForm(request, response);
                break;
            default:
                request.getRequestDispatcher("reports.jsp").forward(request, response);
                break;
        }
    }
    
    private void pendingFeesReport(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Student> students = hostelDAO.getStudentsWithPendingFees();
        request.setAttribute("students", students);
        request.setAttribute("reportTitle", "Students with Pending Fees");
        request.getRequestDispatcher("report_result.jsp").forward(request, response);
    }
    
    private void roomForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setAttribute("reportType", "room-wise");
        request.getRequestDispatcher("report_form.jsp").forward(request, response);
    }
    
    private void dateRangeForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setAttribute("reportType", "date-range");
        request.getRequestDispatcher("report_form.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
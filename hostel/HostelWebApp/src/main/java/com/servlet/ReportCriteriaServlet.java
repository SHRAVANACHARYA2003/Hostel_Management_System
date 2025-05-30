// ReportCriteriaServlet.java
package com.servlet;

import com.dao.HostelDAO;
import com.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/report-criteria")
public class ReportCriteriaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private HostelDAO hostelDAO;
    
    public void init() {
        hostelDAO = new HostelDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String reportType = request.getParameter("reportType");
        
        try {
            switch (reportType) {
                case "room-wise":
                    generateRoomReport(request, response);
                    break;
                case "date-range":
                    generateDateRangeReport(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/reports");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log the error
            request.setAttribute("error", "Error generating report: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    private void generateRoomReport(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String roomNumber = request.getParameter("roomNumber");
        if (roomNumber == null || roomNumber.trim().isEmpty()) {
            throw new IllegalArgumentException("Room number is required");
        }
        
        List<Student> students = hostelDAO.getStudentsByRoom(roomNumber);
        
        request.setAttribute("students", students);
        request.setAttribute("reportTitle", "Students in Room " + roomNumber);
        request.getRequestDispatcher("report_result.jsp").forward(request, response);
    }
    
    private void generateDateRangeReport(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException, ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        
        if (startDateStr == null || startDateStr.trim().isEmpty() || 
            endDateStr == null || endDateStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Both start and end dates are required");
        }
        
        Date startDate = sdf.parse(startDateStr);
        Date endDate = sdf.parse(endDateStr);
        
        if (endDate.before(startDate)) {
            throw new IllegalArgumentException("End date cannot be before start date");
        }
        
        List<Student> students = hostelDAO.getStudentsByDateRange(startDate, endDate);
        
        request.setAttribute("students", students);
        request.setAttribute("reportTitle", "Students Admitted Between " + 
                             sdf.format(startDate) + " and " + sdf.format(endDate));
        request.getRequestDispatcher("report_result.jsp").forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect GET requests to the reports page
        response.sendRedirect(request.getContextPath() + "/reports");
    }
}
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Student" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report Results</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.22/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.6.5/css/buttons.bootstrap4.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            margin-top: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .pending-fees {
            color: #dc3545;
            font-weight: bold;
        }
        .report-header {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/">
            <i class="fas fa-building"></i> Hostel Management
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/add">Add Student</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/list">View Students</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="<%=request.getContextPath()%>/reports">Reports</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <div class="row mt-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-info text-white">
                        <div class="row">
                            <div class="col-md-6">
                                <h4><i class="fas fa-file-alt"></i> Report Results</h4>
                            </div>
                            <div class="col-md-6 text-right">
                                <a href="<%=request.getContextPath()%>/reports" class="btn btn-light">
                                    <i class="fas fa-arrow-left"></i> Back to Reports
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="report-header text-center">
                            <h4><%= request.getAttribute("reportTitle") %></h4>
                            <p>Generated on: <%= new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new java.util.Date()) %></p>
                        </div>
                        
                        <table id="reportTable" class="table table-striped table-bordered">
                            <thead class="thead-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Room</th>
                                    <th>Admission Date</th>
                                    <th>Fees Paid</th>
                                    <th>Pending Fees</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                List<Student> students = (List<Student>) request.getAttribute("students");
                                SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                                if(students != null && !students.isEmpty()) {
                                    for(Student student : students) {
                                %>
                                    <tr>
                                        <td><%= student.getStudentID() %></td>
                                        <td><%= student.getStudentName() %></td>
                                        <td><%= student.getRoomNumber() %></td>
                                        <td><%= sdf.format(student.getAdmissionDate()) %></td>
                                        <td>₹ <%= String.format("%.2f", student.getFeesPaid()) %></td>
                                        <td class="<%= student.getPendingFees() > 0 ? "pending-fees" : "" %>">
                                            ₹ <%= String.format("%.2f", student.getPendingFees()) %>
                                        </td>
                                    </tr>
                                <%
                                    }
                                } else {
                                %>
                                    <tr>
                                        <td colspan="6" class="text-center">No students found matching the criteria.</td>
                                    </tr>
                                <%
                                }
                                %>
                            </tbody>
                            <tfoot>
                                <tr>
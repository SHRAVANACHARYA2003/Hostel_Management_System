<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Student" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Student</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            margin-top: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .delete-warning {
            color: #dc3545;
            font-weight: bold;
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
                <li class="nav-item active">
                    <a class="nav-link" href="<%=request.getContextPath()%>/list">View Students</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/reports">Reports</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <div class="row mt-4">
            <div class="col-md-6 offset-md-3">
                <div class="card">
                    <div class="card-header bg-danger text-white">
                        <h4><i class="fas fa-trash-alt"></i> Delete Student</h4>
                    </div>
                    <div class="card-body text-center">
                        <% 
                        Student student = (Student) request.getAttribute("student");
                        if (student != null) {
                        %>
                            <p class="delete-warning"><i class="fas fa-exclamation-triangle"></i> Are you sure you want to delete this student?</p>
                            <div class="alert alert-warning">
                                <p><strong>Student ID:</strong> <%= student.getStudentID() %></p>
                                <p><strong>Name:</strong> <%= student.getStudentName() %></p>
                                <p><strong>Room Number:</strong> <%= student.getRoomNumber() %></p>
                            </div>
                            <p>This action cannot be undone.</p>
                            
                            <div class="form-group">
                                <a href="<%=request.getContextPath()%>/delete?id=<%= student.getStudentID() %>&confirm=yes" class="btn btn-danger">
                                    <i class="fas fa-trash-alt"></i> Confirm Delete
                                </a>
                                <a href="<%=request.getContextPath()%>/list" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Cancel
                                </a>
                            </div>
                        <%
                        } else {
                        %>
                            <div class="alert alert-danger">
                                <p>Student not found.</p>
                            </div>
                            <a href="<%=request.getContextPath()%>/list" class="btn btn-primary">
                                <i class="fas fa-arrow-left"></i> Back to List
                            </a>
                        <%
                        }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <footer class="bg-dark text-white mt-5 p-4 text-center">
        <div class="container">
            <p>&copy; 2023 Hostel Management System. All Rights Reserved.</p>
        </div>
    </footer>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
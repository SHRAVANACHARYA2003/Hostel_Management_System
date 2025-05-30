<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Student" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Student</title>
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
        .form-section {
            background-color: white;
            padding: 30px;
            border-radius: 5px;
        }
        .required:after {
            content: ' *';
            color: red;
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
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4><i class="fas fa-edit"></i> Update Student</h4>
                    </div>
                    <div class="card-body">
                        <% if(request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger">
                                <%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                        
                        <% 
                        Student student = (Student) request.getAttribute("student");
                        if (student != null) {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            String formattedDate = "";
                            try {
                                if (student.getAdmissionDate() != null) {
                                    formattedDate = sdf.format(student.getAdmissionDate());
                                }
                            } catch (Exception e) {
                                // If date formatting fails, use an empty string
                                formattedDate = "";
                            }
                        %>
                        
                        <p class="lead">Student Details for ID: <%= student.getStudentID() %></p>
                        
                        <form action="<%=request.getContextPath()%>/update" method="post" onsubmit="return validateForm()">
                            <div class="form-group">
                                <label for="studentID" class="required">Student ID</label>
                                <input type="number" class="form-control" id="studentID" name="studentID" value="<%= student.getStudentID() %>" readonly>
                                <small class="form-text text-muted">ID cannot be changed</small>
                            </div>
                            
                            <div class="form-group">
                                <label for="studentName" class="required">Student Name</label>
                                <input type="text" class="form-control" id="studentName" name="studentName" value="<%= student.getStudentName() != null ? student.getStudentName() : "" %>" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="roomNumber" class="required">Room Number</label>
                                <input type="text" class="form-control" id="roomNumber" name="roomNumber" value="<%= student.getRoomNumber() != null ? student.getRoomNumber() : "" %>" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="admissionDate" class="required">Admission Date</label>
                                <input type="date" class="form-control" id="admissionDate" name="admissionDate" value="<%= formattedDate %>" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="feesPaid" class="required">Fees Paid</label>
                                <input type="number" step="0.01" class="form-control" id="feesPaid" name="feesPaid" value="<%= student.getFeesPaid() %>" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="pendingFees" class="required">Pending Fees</label>
                                <input type="number" step="0.01" class="form-control" id="pendingFees" name="pendingFees" value="<%= student.getPendingFees() %>" required>
                            </div>
                            
                            <div class="form-group text-center">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Update Student
                                </button>
                                <a href="<%=request.getContextPath()%>/list" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Cancel
                                </a>
                            </div>
                        </form>
                        <% } else { %>
                            <div class="alert alert-danger">
                                <p>Student not found or an error occurred.</p>
                            </div>
                            <div class="text-center">
                                <a href="<%=request.getContextPath()%>/list" class="btn btn-primary">
                                    <i class="fas fa-arrow-left"></i> Back to Student List
                                </a>
                            </div>
                        <% } %>
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
    
    <script>
        function validateForm() {
            var studentName = document.getElementById("studentName").value;
            var roomNumber = document.getElementById("roomNumber").value;
            var feesPaid = document.getElementById("feesPaid").value;
            var pendingFees = document.getElementById("pendingFees").value;
            
            if (studentName.trim() === "") {
                alert("Student Name cannot be empty");
                return false;
            }
            
            if (roomNumber.trim() === "") {
                alert("Room Number cannot be empty");
                return false;
            }
            
            if (feesPaid < 0) {
                alert("Fees Paid cannot be negative");
                return false;
            }
            
            if (pendingFees < 0) {
                alert("Pending Fees cannot be negative");
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>
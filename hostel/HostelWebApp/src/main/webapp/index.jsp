<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hostel Management System</title>
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
        .jumbotron {
            background-color: #343a40;
            color: white;
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .feature-card {
            transition: transform 0.3s;
        }
        .feature-card:hover {
            transform: translateY(-5px);
        }
        .icon {
            font-size: 3rem;
            margin-bottom: 1rem;
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
                <li class="nav-item active">
                    <a class="nav-link" href="<%=request.getContextPath()%>/">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/add">Add Student</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/list">View Students</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/reports">Reports</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <div class="jumbotron text-center">
            <h1><i class="fas fa-building"></i> Hostel Management System</h1>
            <p class="lead">Efficiently manage student admissions, room allocations, and fee payments</p>
        </div>
        
        <div class="row">
            <div class="col-md-3">
                <div class="card feature-card text-center mb-4">
                    <div class="card-body">
                        <div class="icon text-primary">
                            <i class="fas fa-user-plus"></i>
                        </div>
                        <h5 class="card-title">Add Student</h5>
                        <p class="card-text">Register new students to the hostel system</p>
                        <a href="<%=request.getContextPath()%>/add" class="btn btn-primary">Add Student</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card feature-card text-center mb-4">
                    <div class="card-body">
                        <div class="icon text-success">
                            <i class="fas fa-list"></i>
                        </div>
                        <h5 class="card-title">View Students</h5>
                        <p class="card-text">View and manage all student records</p>
                        <a href="<%=request.getContextPath()%>/list" class="btn btn-success">View Students</a>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card feature-card text-center mb-4">
                    <div class="card-body">
                        <div class="icon text-info">
                            <i class="fas fa-chart-bar"></i>
                        </div>
                        <h5 class="card-title">Reports</h5>
                        <p class="card-text">Generate and view various reports</p>
                        <a href="<%=request.getContextPath()%>/reports" class="btn btn-info">View Reports</a>
                    </div>
                </div>
            </div>
           
                       
                   
                </div>
            </div>
        </div>
        
        <div class="card mt-4">
            <div class="card-header bg-primary text-white">
                <h4>About Hostel Management System</h4>
            </div>
            <div class="card-body">
                <p>The Hostel Management System is a comprehensive solution designed to streamline the management of student hostel facilities. Our system helps administrators efficiently manage:</p>
                <ul>
                    <li>Student admissions and registrations</li>
                    <li>Room allocations and tracking</li>
                    <li>Fee payments and due tracking</li>
                    <li>Generating reports for better decision making</li>
                </ul>
                <p>With an intuitive interface and powerful features, the Hostel Management System makes hostel administration simple and effective.</p>
            </div>
        </div>
    </div>
    
    <footer class="bg-dark text-white mt-5 p-4 text-center">
        <div class="container">
            <p>&copy; 2025 Hostel Management System. All Rights Reserved. for Shravan</p>
        </div>
    </footer>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
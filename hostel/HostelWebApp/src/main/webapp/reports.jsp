<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reports</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            margin-top: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .report-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #007bff;
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
                <div class="jumbotron bg-info text-white">
                    <h1><i class="fas fa-chart-bar"></i> Hostel Reports</h1>
                    <p class="lead">Generate various reports to better manage your hostel</p>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-4">
                <div class="card text-center mb-4">
                    <div class="card-body">
                        <div class="report-icon">
                            <i class="fas fa-money-bill-wave"></i>
                        </div>
                                                <h5 class="card-title">Pending Fees Report</h5>
                        <p class="card-text">View all students with pending fees.</p>
                        <a href="<%=request.getContextPath()%>/reports?action=pending-fees" class="btn btn-primary">
                            <i class="fas fa-file-alt"></i> Generate Report
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card text-center mb-4">
                    <div class="card-body">
                        <div class="report-icon">
                            <i class="fas fa-door-open"></i>
                        </div>
                        <h5 class="card-title">Room-wise Report</h5>
                        <p class="card-text">View students in a specific room.</p>
                        <a href="<%=request.getContextPath()%>/reports?action=room-wise" class="btn btn-success">
                            <i class="fas fa-file-alt"></i> Generate Report
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card text-center mb-4">
                    <div class="card-body">
                        <div class="report-icon">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                        <h5 class="card-title">Date Range Report</h5>
                        <p class="card-text">View students admitted in a specific period.</p>
                        <a href="<%=request.getContextPath()%>/reports?action=date-range" class="btn btn-warning">
                            <i class="fas fa-file-alt"></i> Generate Report
                        </a>
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
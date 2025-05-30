<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report Criteria</title>
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
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <% 
                    String reportType = (String) request.getAttribute("reportType");
                    String cardHeaderClass = "bg-info";
                    String reportTitle = "Report Criteria";
                    String reportIcon = "chart-bar";
                    
                    if ("room-wise".equals(reportType)) {
                        cardHeaderClass = "bg-success";
                        reportTitle = "Room-wise Report";
                        reportIcon = "door-open";
                    } else if ("date-range".equals(reportType)) {
                        cardHeaderClass = "bg-warning";
                        reportTitle = "Date Range Report";
                        reportIcon = "calendar-alt";
                    }
                    %>
                    <div class="card-header <%= cardHeaderClass %> text-white">
                        <h4><i class="fas fa-<%= reportIcon %>"></i> <%= reportTitle %></h4>
                    </div>
                    <div class="card-body">
                        <% if(request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger">
                                <%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                        
                        <form action="<%=request.getContextPath()%>/report-criteria" method="post" onsubmit="return validateForm()">
                            <input type="hidden" name="reportType" value="<%= reportType %>">
                            
                            <% if ("room-wise".equals(reportType)) { %>
                                <div class="form-group">
                                    <label for="roomNumber" class="required">Room Number</label>
                                    <input type="text" class="form-control" id="roomNumber" name="roomNumber" required>
                                    <small class="form-text text-muted">Enter the room number to view its occupants</small>
                                </div>
                            <% } else if ("date-range".equals(reportType)) { %>
                                <div class="form-group">
                                    <label for="startDate" class="required">Start Date</label>
                                    <input type="date" class="form-control" id="startDate" name="startDate" required>
                                </div>
                                
                                <div class="form-group">
                                    <label for="endDate" class="required">End Date</label>
                                    <input type="date" class="form-control" id="endDate" name="endDate" required>
                                </div>
                            <% } %>
                            
                            <div class="form-group text-center">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-search"></i> Generate Report
                                </button>
                                <a href="<%=request.getContextPath()%>/reports" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Cancel
                                </a>
                            </div>
                        </form>
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
            <% if ("date-range".equals(reportType)) { %>
                var startDate = new Date(document.getElementById("startDate").value);
                var endDate = new Date(document.getElementById("endDate").value);
                
                if (endDate < startDate) {
                    alert("End date cannot be earlier than start date");
                    return false;
                }
            <% } %>
            return true;
        }
    </script>
</body>
</html>
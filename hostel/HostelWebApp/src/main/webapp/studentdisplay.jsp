<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Student" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student List</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.22/css/dataTables.bootstrap4.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            margin-top: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .table-actions {
            display: flex;
            justify-content: space-around;
        }
        .pending-fees {
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
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <div class="row">
                            <div class="col-md-6">
                                <h4><i class="fas fa-list"></i> Student List</h4>
                            </div>
                            <div class="col-md-6 text-right">
                                <a href="<%=request.getContextPath()%>/add" class="btn btn-light">
                                    <i class="fas fa-user-plus"></i> Add New Student
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <% if(request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger">
                                <%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                        
                        <table id="studentTable" class="table table-striped table-bordered">
                            <thead class="thead-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Room</th>
                                    <th>Admission Date</th>
                                    <th>Fees Paid</th>
                                    <th>Pending Fees</th>
                                    <th>Actions</th>
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
                                        <td class="table-actions">
                                            <a href="<%=request.getContextPath()%>/view?id=<%= student.getStudentID() %>" class="btn btn-info btn-sm">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a href="<%=request.getContextPath()%>/update?id=<%= student.getStudentID() %>" class="btn btn-primary btn-sm">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="<%=request.getContextPath()%>/delete?id=<%= student.getStudentID() %>" class="btn btn-danger btn-sm">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
                                        </td>
                                    </tr>
                                <%
                                    }
                                } else {
                                %>
                                    <tr>
                                        <td colspan="7" class="text-center">No students found.</td>
                                    </tr>
                                <%
                                }
                                %>
                            </tbody>
                        </table>
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
    
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.22/js/dataTables.bootstrap4.min.js"></script>
    
    <script>
        $(document).ready(function() {
            $('#studentTable').DataTable({
                "pageLength": 10,
                "language": {
                    "lengthMenu": "Show _MENU_ students per page",
                    "zeroRecords": "No students found",
                    "info": "Showing page _PAGE_ of _PAGES_",
                    "infoEmpty": "No students available",
                    "infoFiltered": "(filtered from _MAX_ total students)"
                }
            });
        });
    </script>
</body>
</html>
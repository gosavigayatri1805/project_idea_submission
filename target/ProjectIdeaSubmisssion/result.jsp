
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Project Idea Submission Result</title>
</head>

<body style="text-align:center; background-color:beige;">

<h2>Saved!</h2>
<h2>All Records</h2>

<%
    String url = "jdbc:mysql://localhost:3306/project_idea_sub";
    String user = "root";
    String pass = "Gayu@2004";

    Connection con = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, user, pass);

        if ("POST".equalsIgnoreCase(request.getMethod())) {

            String student = request.getParameter("Stud");
            String title = request.getParameter("title");
            String domain = request.getParameter("domain");
            String description = request.getParameter("des");

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO project_idea(student, title, domain, description) VALUES (?, ?, ?, ?)"
            );

            ps.setString(1, student);
            ps.setString(2, title);
            ps.setString(3, domain);
            ps.setString(4, description);

            ps.executeUpdate();
            ps.close();
        }

        String search = request.getParameter("search");
        String sql = "SELECT * FROM project_idea";

        if (search != null && !search.trim().isEmpty()) {
            sql += " WHERE title LIKE ?";
        }

        PreparedStatement ps = con.prepareStatement(sql);

        if (search != null && !search.trim().isEmpty()) {
            ps.setString(1, "%" + search + "%");
        }

        ResultSet rs = ps.executeQuery();
        int count = 0;
%>


<br>

<table border="1" align="center" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Student</th>
        <th>Title</th>
        <th>Domain</th>
        <th>Description</th>
    </tr>

<%
        while (rs.next()) {
            count++;
%>

    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("student") %></td>
        <td><%= rs.getString("title") %></td>
        <td><%= rs.getString("domain") %></td>
        <td><%= rs.getString("description") %></td>
    </tr>

<%
        }

        rs.close();
        ps.close();
        con.close();
%>

</table>

<p>Total records: <%= count %></p>

<%
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>

<p align="center">
    <a href="index.html">Add another Idea</a>
</p>
</body>
</html>
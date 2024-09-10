<%@ page import="com.fashionkart.entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User loggedInUser = session.getAttribute("user") == null ? null : ((User) (session.getAttribute("user")));

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Men T-Shirts - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:ital,wght@0,300;0,400;1,600&display=swap"
          rel="stylesheet"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lazysizes/5.3.0/lazysizes.min.js" async=""></script>
    <script src="/js/cart.js"></script>
</head>
<body class="bg-gray-50 text-gray-800">
<%--      nav bar--%>
      <%@include file="navbar.jsp" %>

</body>
</html>
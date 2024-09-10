<%@ page import="com.fashionkart.entities.Seller" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.fashionkart.service.SellerService" %>
<%@ page import="com.fashionkart.serviceimpl.SellerServiceImpl" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Details - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .card {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body class="bg-gray-200">
<%
    String email = request.getParameter("email");
    if (email == null) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        return;
    }
    SellerService sellerService = new SellerServiceImpl();
    Seller seller = sellerService.getByEmail(email);
    if (seller == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND);
        return;
    }
%>
<!-- Seller Information -->
<div class="flex w-full">
    <%@include file="admin-sidebar.jsp" %>
    <!-- Main Content -->
    <div class="ml-64 p-8 w-full">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-4xl font-bold text-gray-900">Seller Details</h1>
            <a href="/admin/dashboard" class="text-blue-600 hover:text-blue-800">Back</a>
        </div>
        <div class="bg-white p-8 rounded-lg shadow-md">
            <table class="min-w-full bg-white border border-gray-200 rounded-lg shadow-md">
                <thead>
                <tr class="w-full bg-gray-100 border-b">
                    <th class="py-2 px-4 text-left text-gray-700">Field</th>
                    <th class="py-2 px-4 text-left text-gray-700">Value</th>
                </tr>
                </thead>
                <tbody>
                <tr class="border-b">
                    <td class="py-2 px-4 font-medium text-gray-600">Name</td>
                    <td class="py-2 px-4"><%= seller.getName() %>
                    </td>
                </tr>
                <tr class="border-b">
                    <td class="py-2 px-4 font-medium text-gray-600">Email</td>
                    <td class="py-2 px-4"><%= seller.getEmail() %>
                    </td>
                </tr>
                <tr class="border-b">
                    <td class="py-2 px-4 font-medium text-gray-600">Phone Number</td>
                    <td class="py-2 px-4"><%= seller.getPhoneNumber() %>
                    </td>
                </tr>
                <tr class="border-b">
                    <td class="py-2 px-4 font-medium text-gray-600">Business Name</td>
                    <td class="py-2 px-4"><%= seller.getBusinessName() %>
                    </td>
                </tr>
                <tr class="border-b">
                    <td class="py-2 px-4 font-medium text-gray-600">Business Address</td>
                    <td class="py-2 px-4"><%= seller.getBusinessAddress() %>
                    </td>
                </tr>
                <tr class="border-b">
                    <td class="py-2 px-4 font-medium text-gray-600">Support Email</td>
                    <td class="py-2 px-4"><%= seller.getSupportEmail() %>
                    </td>
                </tr>
                <tr class="border-b">
                    <td class="py-2 px-4 font-medium text-gray-600">Support Contact</td>
                    <td class="py-2 px-4"><%= seller.getSupportContact() %>
                    </td>
                </tr>
                <tr class="border-b">
                    <td class="py-2 px-4 font-medium text-gray-600">Registered On</td>
                    <td class="py-2 px-4"><%= seller.getRegisteredOn().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) %>
                    </td>
                </tr>
                <tr>
                    <td class="py-2 px-4 font-medium text-gray-600">Description</td>
                    <td class="py-2 px-4"><%= seller.getDescription() %>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>

<%@ page import="com.fashionkart.entities.Seller" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionkart.utils.Constants" %>
<%@ page import="com.fashionkart.service.SellerService" %>
<%@ page import="com.fashionkart.serviceimpl.SellerServiceImpl" %>
<%@ page import="java.util.Map" %>
<html>
<head>
    <title>Admin Dashboard - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        /* Custom styles */
        .table-header {
            background-color: #f3f4f6;
            color: #1f2937;
        }
    </style>
</head>
<body class="bg-gray-100">
<div class="flex w-full">
    <%@include file="admin-sidebar.jsp" %>
    <%
        int currentPage = request.getParameter("pageNumber") != null ? Integer.parseInt(request.getParameter("pageNumber")) : 1;
        SellerService sellerService = new SellerServiceImpl();
        int pageSize = Constants.DEFAULT_PAGE_SIZE;

        Map.Entry<List<Seller>, Long> entry = sellerService.getPaginatedSellers(currentPage, pageSize);
        long totalItems = entry.getValue();
        List<Seller> sellers = entry.getKey();
        long totalPages = (long) Math.ceil((double) totalItems / pageSize);
    %>
    <!-- Main Content -->
    <div class="ml-64 p-8 w-full">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-3xl font-semibold text-gray-800">Sellers</h1>
            <form action="/admin/seller/info" method="POST" class="flex space-x-4">
                <input type="email"
                        name="email"
                        placeholder="Search by email"
                        class="px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-600"
                        required
                >
                <button
                        type="submit"
                        class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-800 focus:outline-none focus:ring-2 focus:ring-blue-600"
                >
                    Search
                </button>
            </form>
            <a href="/admin/dashboard" class="text-blue-600 hover:text-blue-800">Back</a>
        </div>

        <div class="bg-white p-8 rounded-lg shadow-md">
            <!-- Seller Table -->
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="table-header">
                <tr>
                    <th class="py-3 px-6 text-left text-xs font-medium uppercase tracking-wider">ID</th>
                    <th class="py-3 px-6 text-left text-xs font-medium uppercase tracking-wider">Name</th>
                    <th class="py-3 px-6 text-left text-xs font-medium uppercase tracking-wider">Email</th>
                    <th class="py-3 px-6 text-left text-xs font-medium uppercase tracking-wider">Business Name</th>
                    <th class="py-3 px-6 text-left text-xs font-medium uppercase tracking-wider">Phone</th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                <%
                    for (Seller seller : sellers) {
                %>
                <tr>
                    <td class="py-4 px-6 text-sm text-gray-900"><%= seller.getId() %></td>
                    <td class="py-4 px-6 text-sm text-gray-900"><%= seller.getName() %></td>
                    <td class="py-4 px-6 text-sm text-gray-900"><%= seller.getEmail() %></td>
                    <td class="py-4 px-6 text-sm text-gray-900"><%= seller.getBusinessName() %></td>
                    <td class="py-4 px-6 text-sm text-gray-900"><%= seller.getPhoneNumber() %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <div class="mt-6 flex justify-between items-center">
            <a href="?pageNumber=<%= Math.max(currentPage - 1, 1) %>"
               class="text-blue-500 px-4 py-2 rounded-lg bg-gray-100 hover:bg-gray-200
               <% if (currentPage == 1) { %> cursor-not-allowed text-gray-400 <% } %>">
                Previous
            </a>
            <span class="text-gray-600">Page <%= currentPage %> of <%= totalPages %></span>
            <a href="?pageNumber=<%= Math.min(currentPage + 1, (int) totalPages) %>"
               class="text-blue-500 px-4 py-2 rounded-lg bg-gray-100 hover:bg-gray-200
               <% if (currentPage >= totalPages) { %> cursor-not-allowed text-gray-400 <% } %>">
                Next
            </a>
        </div>
    </div>
</div>
</body>
</html>

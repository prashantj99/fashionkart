<%@ page import="com.fashionkart.service.OrderService" %>
<%@ page import="com.fashionkart.repository.OrderRepository" %>
<%@ page import="com.fashionkart.repositoryimpl.OrderRepositoryImpl" %>
<%@ page import="com.fashionkart.entities.User" %>
<%@ page import="com.fashionkart.entities.UserOrder" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>Admin Dashboard - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body class="bg-gray-50">
<!-- Sidebar -->

<div class="flex w-full">
    <%@include file="admin-sidebar.jsp" %>
    <%
        String email = request.getParameter("email");
        if(email == null){
            out.println("<div class=\"bg-red-100 text-red-900 p-8 rounded shadow-lg\">\n" +
                    "            <p>User email is required!!!</p>\n" +
                    "        </div>");
            return;
        }
        OrderRepository orderRepository = new OrderRepositoryImpl();
        List<UserOrder> userOrders = orderRepository.findWhereUserEmailIs(email);
    %>
    <!-- Main Content -->
    <div class="ml-64 p-8 w-full">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-3xl font-semibold text-gray-800">Orders for User: <%= email %></h1>
            <a href="/admin/dashboard" class="text-blue-600 hover:text-blue-800">Back</a>
        </div>

        <div class="bg-white p-8 rounded-xl shadow-md">
            <table class="min-w-full table-auto border-collapse">
                <thead class="bg-gray-100 text-gray-600 uppercase text-sm leading-normal">
                <tr>
                    <th class="px-6 py-3 text-left">Order ID</th>
                    <th class="px-6 py-3 text-left">Order Date</th>
                    <th class="px-6 py-3 text-left">Delivery Date</th>
                    <th class="px-6 py-3 text-left">Total Amount</th>
                    <th class="px-6 py-3 text-left">Status</th>
                </tr>
                </thead>
                <tbody class="text-gray-700 text-sm">
                <%
                    if (userOrders != null && !userOrders.isEmpty()) {
                        for (UserOrder order : userOrders) {
                            // Define colors for the statuses
                            String statusClass = "";
                            String statusIcon = "";
                            switch(order.getStatus()) {
                                case "COMPLETED":
                                    statusClass = "bg-green-100 text-green-800";
                                    statusIcon = "&#x2705;";
                                    break;
                                case "PENDING":
                                    statusClass = "bg-yellow-100 text-yellow-800";
                                    statusIcon = "&#x23F3;";
                                    break;
                                case "CANCELLED":
                                    statusClass = "bg-red-100 text-red-800";
                                    statusIcon = "&#x274C;";
                                    break;
                                default:
                                    statusClass = "bg-gray-100 text-gray-800";
                                    statusIcon = "&#x2754;";
                                    break;
                            }
                %>
                <tr class="border-b border-gray-200 hover:bg-gray-50 transition-all duration-150 ease-in-out">
                    <td class="px-6 py-4 whitespace-nowrap">
                        <span class="font-semibold text-gray-800"><%= order.getId() %></span>
                    </td>
                    <td class="px-6 py-4">
                        <%= order.getOrderDate() != null ? order.getOrderDate().toLocalDate() : "N/A" %>
                    </td>
                    <td class="px-6 py-4">
                        <%= order.getExpectedDelivery() != null ? order.getExpectedDelivery().toLocalDate() : "N/A" %>
                    </td>
                    <td class="px-6 py-4">
                        INR <%= String.format("%.2f", order.getTotalAmount()) %>
                    </td>
                    <td class="px-6 py-4">
                            <span class="flex items-center gap-2 px-3 py-1 rounded-full <%= statusClass %>">
                                <%= statusIcon %> <%= order.getStatus() %>
                            </span>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="5" class="px-6 py-4 text-center text-gray-500">No orders found for this user.</td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>

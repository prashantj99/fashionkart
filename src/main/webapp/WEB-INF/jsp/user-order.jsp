<%@ page import="com.fashionkart.entities.User" %>
<%@ page import="com.fashionkart.service.OrderService" %>
<%@ page import="com.fashionkart.serviceimpl.OrderServiceImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionkart.entities.UserOrder" %>
<%@ page import="com.fashionkart.utils.Constants" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

<%
    // Fetch and process query parameters
    int pageNumber = request.getParameter("pageNumber") != null && !request.getParameter("pageNumber").isEmpty()
            ? Integer.parseInt(request.getParameter("pageNumber"))
            : 1;

    String searchQuery = request.getParameter("searchQuery") != null && !request.getParameter("searchQuery").isEmpty()
            ? request.getParameter("searchQuery")
            : null;
    Long monthsAgo = request.getParameter("monthsAgo") != null && !request.getParameter("monthsAgo").isEmpty()
            ? Long.parseLong(request.getParameter("monthsAgo"))
            : null;

    String status = request.getParameter("status") != null && !request.getParameter("status").isEmpty()
            ? request.getParameter("status")
            : null;

    int pageSize = Constants.DEFAULT_PAGE_SIZE;
    User loggedInUser = (User) session.getAttribute("user");
    OrderService orderService = new OrderServiceImpl();

    // Fetch filtered orders and total count
    Map.Entry<List<UserOrder>, Long> ordersAndCount = orderService.getFilteredOrdersByUser(
            loggedInUser.getId(), searchQuery, status, monthsAgo, pageNumber, pageSize
    );

    List<UserOrder> userOrders = ordersAndCount.getKey();
    long totalOrders = ordersAndCount.getValue();
    // Calculate the total number of pages
    int totalPages = (int) Math.ceil((double) totalOrders / pageSize);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/razorpay@2.1.3/dist/checkout.js"></script>
</head>
<body class="bg-gray-100">

<!-- Header -->
<%@include file="navbar.jsp"%>
<section>
    <div class="min-h-screen bg-gray-100 p-6">
        <!-- Breadcrumb -->
        <nav class="text-sm text-gray-500 mb-6">
            <ol class="flex items-center space-x-2">
                <li><a href="#" class="text-blue-600 hover:underline">Home</a></li>
                <li>/</li>
                <li><a href="#" class="text-blue-600 hover:underline">My account</a></li>
                <li>/</li>
                <li class="text-gray-700">All orders</li>
            </ol>
        </nav>

        <div class="flex flex-col md:flex-row gap-6">
            <!-- Sidebar -->
            <aside class="bg-white w-full h-screen md:w-1/4 p-4 rounded-lg shadow-md">
                <div class="text-center mb-6">
                    <img class="w-20 h-20 rounded-full mx-auto" src="<%=FirebaseStorageUtil.generateSignedUrl(loggedInUser.getImage())%>" alt="User Avatar">
                    <h2 class="mt-3 text-lg font-semibold"><%=loggedInUser.getFirstName()%> (Personal)</h2>
                    <p class="text-gray-500"><%= loggedInUser.getEmail() %>
                    </p>
                </div>

                <ul class="space-y-4">
                    <li><a href="#" class="flex items-center space-x-2 text-blue-600"><i class="fas fa-user"></i> <span>Profile</span></a>
                    </li>
                    <li><a href="#" class="flex items-center space-x-2"><i class="fas fa-box"></i><span>My orders</span></a>
                    </li>
                    <li><a href="#" class="flex items-center space-x-2"><i class="fas fa-star"></i> <span>Reviews</span></a>
                    </li>
                    <li><a href="#" class="flex items-center space-x-2"><i class="fas fa-map-marker-alt"></i> <span>Delivery addresses</span></a>
                    </li>
                    <li><a href="#" class="flex items-center space-x-2"><i class="fas fa-heart"></i>
                        <span>Wishlist</span></a></li>
                    <li><a href="#" class="flex items-center space-x-2"><i class="fas fa-cog"></i> <span>Settings</span></a>
                    </li>
                    <li><a href="/controller/logout" class="flex items-center space-x-2 text-red-600"><i
                            class="fas fa-sign-out-alt"></i><span>Log out</span></a></li>
                </ul>
            </aside>

            <!-- Orders Content -->
            <div class="w-full md:w-3/4">
                <!-- Search & Filters -->
                <form method="post" action="/user/orders" class="flex flex-col md:flex-row justify-between mb-6 gap-4">
                    <div class="flex items-center space-x-2 w-full md:w-1/2">
                        <input type="text" name="searchQuery" class="w-full p-2 border rounded-lg"
                               placeholder="Search orders..."/>
                        <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded-lg">Search</button>
                    </div>
                    <div class="flex space-x-4 w-full md:w-auto">
                        <select name="status" class="border p-2 rounded-lg">
                            <option value="">Filter by: All</option>
                            <option value="COMPLETED">Completed</option>
                            <option value="PENDING">Pending</option>
                            <option value="CANCELLED">Cancelled</option>
                        </select>
                        <select name="monthsAgo" class="border p-2 rounded-lg">
                            <option value="">All time</option>
                            <option value="1">Last 1 Months</option>
                            <option value="6">Last 6 Months</option>
                            <option value="12">Last Year</option>
                        </select>
                        <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded-lg">Apply</button>
                        <a class="bg-red-600 text-white px-4 py-2 rounded-lg" href="/user/orders">Reset</a>
                    </div>
                </form>
                <!-- Orders List -->
                <div class="space-y-4">
                    <% if (userOrders != null && !userOrders.isEmpty()) { %>
                    <% for (UserOrder order : userOrders) { %>
                    <div class="bg-white p-4 rounded-lg shadow-md">
                        <% if (order.getStatus().equalsIgnoreCase("completed")) {%>
                        <div class="inline-flex gap-2 items-center">
                            <img width="24" height="24" src="https://img.icons8.com/windows/32/download--v1.png"
                                 alt="download--v1"/>
                            <a href="#" class="block font-semibold mt-2 text-blue-600 hover:underline">Download
                                Invoice</a>
                        </div>
                        <%}%>
                        <div class="flex justify-between items-baseline">
                            <div>
                                <p class="font-bold text-gray-700">Order ID:
                                    <span class="text-blue-600">#<%= order.getId() %></span>
                                </p>
                                <%
                                    String statusClass = "bg-green-500";
                                    String statusMsg = "Completed!";
                                    if (order.getStatus().equalsIgnoreCase("pending")) {
                                        statusClass = "bg-yellow-500";
                                        statusMsg = "Pending!";
                                    } else if (order.getStatus().equalsIgnoreCase("cancelled")) {
                                        statusClass = "bg-red-500";
                                        statusMsg = "Cancelled!";
                                    }
                                %>
                                <div class="<%=statusClass%> text-white items-center space-x-1 text-xs font-semibold rounded-xl tracking-wide inline-flex px-2 py-1 mt-1">
                                    <img width="12" height="12"
                                         src="https://img.icons8.com/material-outlined/24/ground-transportation.png"
                                         alt="ground-transportation"/>
                                    <span>
                                         <%= statusMsg %>
                                        </span>
                                </div>
                            </div>

                            <div class="flex space-x-2">
                                <% if (order.getStatus().equalsIgnoreCase("pending")) { %>
                                <!-- Cancel Order Button -->
                                <form action="/controller/order/cancel" method="post">
                                    <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                    <button type="submit" class="bg-red-500 text-white px-3 py-2 rounded-lg">Cancel
                                        Order
                                    </button>
                                </form>
                                <% } %>
                                <button class="bg-gray-100 text-blue-600 px-3 py-2 rounded-lg">Order details</button>
                            </div>
                        </div>

                        <div class="flex justify-between w-full mt-4 p-3">
                            <p class="text-gray-500">Email: <%= loggedInUser.getEmail() %>
                            </p>
                            <p class="text-gray-500">Phone: <%= loggedInUser.getPhoneNumber() %>
                            </p>
                            <p class="text-gray-500">Payment method: <span class="text-blue-500"> UPI </span></p>
                        </div>
                        <% if (order.getStatus().equalsIgnoreCase("pending")) {%>
                            <p class="mt-2 bg-yellow-50 p-5 rounded-lg text-xl">Deliver By <%= order.getExpectedDelivery().toLocalDate() %>
                            </p>
                        <%} else if(order.getStatus().equalsIgnoreCase("COMPLETED")){%>
                        <p class="mt-2 border-1 text-red-500 p-5 rounded-lg text-sm">
                            <a href="#" class="border-2 border-red-500 text-red-500 font-semibold px-4 py-2 rounded-lg hover:bg-red-500 hover:text-white transition-all duration-300 ease-in-out">
                                Write Review
                            </a>
                        </p>
                        <%}%>
                    </div>
                    <% } %>
                    <% } else { %>
                    <p class="text-gray-500">No orders found.</p>
                    <% } %>
                </div>
                <!-- Pagination -->
                <nav aria-label="Page navigation" class="mt-6">
                    <ul class="flex justify-center space-x-2">
                        <% if (pageNumber > 1) { %>
                        <li><a href="?pageNumber=<%= pageNumber - 1 %>"
                               class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">Previous</a>
                        </li>
                        <% } %>
                        <% for (int i = 1; i <= totalPages; i++) { %>
                        <li>
                            <a href="?pageNumber=<%= i %>"
                               class="px-4 py-2 <% if (i == pageNumber) { %>bg-blue-600 text-white rounded-lg<% } %> hover:bg-blue-700"><%= i %>
                            </a>
                        </li>
                        <% } %>
                        <% if (pageNumber < totalPages) { %>
                        <li><a href="?pageNumber=<%= pageNumber + 1 %>"
                               class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700">Next</a></li>
                        <% } %>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</section>

</body>
</html>

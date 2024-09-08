<%@ page import="com.fashionkart.entities.Discount" %>
<%@ page import="com.fashionkart.service.DiscountService" %>
<%@ page import="com.fashionkart.serviceimpl.DiscountServiceImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionkart.entities.Seller" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Discounts - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">

<section class="py-16">
    <div class="container mx-auto max-w-4xl bg-white p-8 rounded-lg shadow-lg">
        <h2 class="text-3xl font-bold mb-6 text-primary">Manage Discounts</h2>

        <%
            Seller seller = (Seller) request.getSession().getAttribute("seller");
            if (seller == null) {
                response.sendRedirect("/auth/sellers/login");
                return;
            }

            DiscountService discountService = new DiscountServiceImpl();
            List<Discount> discounts = discountService.getDiscountsBySeller(seller.getId());
        %>

        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="mb-4 bg-red-100 text-red-700 p-4 rounded-lg">
            <%= request.getAttribute("errorMessage") %>
        </div>
        <% } %>

        <% if (request.getAttribute("successMessage") != null) { %>
        <div class="mb-4 bg-green-100 text-green-700 p-4 rounded-lg">
            <%= request.getAttribute("successMessage") %>
        </div>
        <% } %>

        <table class="min-w-full bg-white border border-gray-200 rounded-lg shadow-md">
            <thead>
            <tr class="bg-gray-200 text-gray-600">
                <th class="py-2 px-4 border-b">Code</th>
                <th class="py-2 px-4 border-b">Percentage</th>
                <th class="py-2 px-4 border-b">Description</th>
                <th class="py-2 px-4 border-b">Min Value</th>
                <th class="py-2 px-4 border-b">Start Date</th>
                <th class="py-2 px-4 border-b">End Date</th>
                <th class="py-2 px-4 border-b">Action</th>
            </tr>
            </thead>
            <tbody>
            <% for (Discount discount : discounts) { %>
            <tr>
                <td class="py-2 px-4 border-b"><%= discount.getCode() %></td>
                <td class="py-2 px-4 border-b"><%= discount.getPercentage() %></td>
                <td class="py-2 px-4 border-b"><%= discount.getDescription() %></td>
                <td class="py-2 px-4 border-b"><%= discount.getMinimumValue() %></td>
                <td class="py-2 px-4 border-b"><%= discount.getStartDate() %></td>
                <td class="py-2 px-4 border-b"><%= discount.getEndDate() %></td>
                <td class="py-2 px-4 border-b">
                    <form action="<%= request.getContextPath() %>/controller/discount/delete" method="post" onsubmit="return confirm('Are you sure you want to delete this discount?');">
                        <input type="hidden" name="id" value="<%= discount.getId() %>">
                        <button type="submit" class="bg-red-500 text-white px-4 py-2 rounded-md hover:bg-red-600">Delete</button>
                    </form>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</section>

</body>
</html>

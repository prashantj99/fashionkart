<%@ page import="com.fashionkart.entities.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionkart.service.CategoryService" %>
<%@ page import="com.fashionkart.serviceimpl.CategoryServiceImpl" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Discount - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">

<section class="py-12">
    <div class="container mx-auto max-w-xl bg-white p-8 rounded-lg shadow-lg">
        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="mb-4 bg-red-100 text-red-700 border border-red-400 p-4 rounded">
            <%= request.getAttribute("errorMessage") %>
        </div>
        <% } %>

        <form action="<%= request.getContextPath() %>/controller/discount/add" method="post" class="space-y-6">
            <div>
                <label for="code" class="block text-sm font-medium text-gray-700">Discount Code</label>
                <input type="text" id="code" name="code"
                       class="mt-1 block w-full p-3 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500"
                       required>
            </div>
            <div class="flex w-full gap-5">
                <div class="w-full">
                    <label for="percentage" class="block text-sm font-medium text-gray-700">Discount Percentage</label>
                    <input type="number" step="0.01" id="percentage" name="percentage"
                           class="mt-1 block w-full p-3 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500"
                           required>
                </div>
                <div class="w-full">
                    <label for="minimumValue" class="block text-sm font-medium text-gray-700">Minimum Value</label>
                    <input type="number" step="0.01" id="minimumValue" name="minimumValue"
                           class="mt-1 block w-full p-3 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500"
                           required>
                </div>
            </div>
            <div>
                <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
                <textarea id="description" name="description"
                          class="mt-1 block w-full p-3 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500"
                          rows="3" required></textarea>
            </div>


            <div>
                <label for="categoryId" class="block text-sm font-medium text-gray-700">Applicable Category</label>
                <select id="categoryId" name="categoryId"
                        class="mt-1 block w-full p-3 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500"
                        required>
                    <%
                        CategoryService categoryService = new CategoryServiceImpl();
                        List<Category> categories = categoryService.findAll();
                        for (Category category : categories) {
                    %>
                    <option value="<%= category.getId() %>"><%= category.getName() %>
                    </option>
                    <% } %>
                </select>
            </div>
            <div class="flex gap-5 w-full">
                <div class="w-full">
                    <label for="startDate" class="block text-sm font-medium text-gray-700">Start Date</label>
                    <input type="date" id="startDate" name="startDate"
                           class="mt-1 block w-full p-3 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500"
                           required>
                </div>

                <div class="w-full">
                    <label for="endDate" class="block text-sm font-medium text-gray-700">End Date</label>
                    <input type="date" id="endDate" name="endDate"
                           class="mt-1 block w-full p-3 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500"
                           required>
                </div>
            </div>
            <div>
                <button type="submit"
                        class="w-full bg-gray-600 text-white font-bold py-3 px-4 rounded-lg hover:bg-gray-700 focus:ring-4 focus:ring-gray-500">
                    Add Discount
                </button>
            </div>
        </form>
    </div>
</section>

</body>
</html>

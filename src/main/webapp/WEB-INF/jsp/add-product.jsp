<%@ page import="com.fashionkart.entities.Category, com.fashionkart.entities.Brand" %>
<%@ page import="com.fashionkart.service.CategoryService, com.fashionkart.service.BrandService" %>
<%@ page import="com.fashionkart.serviceimpl.CategoryServiceImpl, com.fashionkart.serviceimpl.BrandServiceImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionkart.entities.GenderType" %>
<%@ page import="com.fashionkart.entities.ProductSize" %>

<div class="max-w-3xl mx-auto bg-white p-4 rounded-lg shadow-md">
    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="bg-red-100 text-red-700 border border-red-300 rounded p-4 mb-6">
        <%= request.getAttribute("errorMessage") %>
    </div>
    <% } %>

    <form action="/controller/add-product" method="post" enctype="multipart/form-data" class="space-y-6">
        <div>
            <label for="name" class="block text-lg text-gray-700 font-medium mb-2">Product Name</label>
            <input type="text" id="name" name="name"
                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200"
                   required>
        </div>

        <div>
            <label for="description" class="block text-lg text-gray-700 font-medium mb-2">Description</label>
            <textarea id="description" name="description"
                      class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200"
                      required></textarea>
        </div>

        <div class="flex gap-5 w-full">
            <div class="w-full">
                <label for="price" class="block text-lg text-gray-700 font-medium mb-2">Price</label>
                <input type="number" id="price" name="price" step="0.01"
                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200"
                       required>
            </div>
            <div class="w-full">
                <label for="quantityAvailable" class="block text-lg text-gray-700 font-medium mb-2">Quantity
                    Available</label>
                <input type="number" id="quantityAvailable" name="quantityAvailable"
                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200"
                       required>
            </div>
        </div>
        <div class="flex gap-5 w-full">
            <div class="w-full">
                <label for="genderType" class="block text-lg text-gray-700 font-medium mb-2">Gender Type</label>
                <select id="genderType" name="genderType"
                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200"
                        required>
                    <% for (GenderType genderType : GenderType.values()) { %>
                    <option value="<%= genderType %>"><%= genderType %>
                    </option>
                    <% } %>
                </select>
            </div>

            <div class="w-full">
                <label for="availableProductSizes" class="block text-lg text-gray-700 font-medium mb-2">Available
                    Product
                    Sizes</label>
                <select id="availableProductSizes" name="productSizes" multiple
                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200"
                        required>
                    <% for (ProductSize productSize : ProductSize.values()) { %>
                    <option value="<%= productSize %>"><%= productSize %>
                    </option>
                    <% } %>
                </select>
            </div>
        </div>
        <div class="flex gap-5 w-full">
            <div class="w-full">
                <label for="category" class="block text-lg text-gray-700 font-medium mb-2">Category</label>
                <select id="category" name="category"
                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200"
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

            <div class="w-full">
                <label for="brand" class="block text-lg text-gray-700 font-medium mb-2">Brand</label>
                <select id="brand" name="brand"
                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200"
                        required>
                    <%
                        BrandService brandService = new BrandServiceImpl();
                        List<Brand> brands = brandService.getAllBrands();
                        for (Brand brand : brands) {
                    %>
                    <option value="<%= brand.getId() %>"><%= brand.getName() %>
                    </option>
                    <% } %>
                </select>
            </div>
        </div>
        <div>
            <label for="images" class="block text-lg text-gray-700 font-medium mb-2">Product Images</label>
            <input type="file" id="images" name="images" multiple
                   class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 transition duration-200">
        </div>

        <div class="w-full flex justify-center items-center">
            <button type="submit"
                    class="w-full bg-gray-600 text-white px-6 py-3 rounded-lg hover:bg-gray-700 transition duration-200 font-semibold">
                Add Now
            </button>
        </div>
    </form>
</div>

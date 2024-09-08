<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Category - FashionKart</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
  <style>
    .btn-primary {
      background-color: #000000; /* Black */
      color: #FFFFFF;
    }
    .btn-primary:hover {
      background-color: #333333; /* Dark Gray */
    }
    .bg-primary {
      background-color: #FFFFFF; /* White */
    }
    .text-primary {
      color: #000000; /* Black */
    }
    .text-secondary {
      color: #4B5563; /* Gray-600 */
    }
    .border-primary {
      border-color: #000000; /* Black */
    }
    .focus-ring-primary:focus {
      border-color: #000000; /* Black */
      box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.3); /* Light shadow */
    }
  </style>
</head>
<body class="bg-gray-50">
<section class="py-8">
  <div class="container mx-auto max-w-3xl bg-white p-8 rounded-lg shadow-md">
    <!-- Display server-side error message if any -->
    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="mb-4 bg-red-100 text-red-700 p-4 rounded-lg">
      <%= request.getAttribute("errorMessage") %>
    </div>
    <% } %>
    <!-- Display success message if any -->
    <% if ("true".equals(request.getParameter("success"))) { %>
    <div class="mb-4 bg-green-100 text-green-700 p-4 rounded-lg">
      Category added successfully!
    </div>
    <% } %>

    <form action="/controller/category/add" method="post">
      <div class="mb-6">
        <label for="categoryName" class="block text-secondary text-lg font-medium mb-2">Category Name</label>
        <input type="text" id="categoryName" name="categoryName"
               class="w-full px-4 py-3 border border-primary rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
               placeholder="Enter category name" required>
      </div>
      <div class="mb-6">
        <label for="description" class="block text-secondary text-lg font-medium mb-2">Description</label>
        <textarea id="description" name="description" rows="4"
                  class="w-full px-4 py-3 border border-primary rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                  placeholder="Enter category description" required></textarea>
      </div>
      <button type="submit"
              class="w-full px-4 py-3 btn-primary font-semibold rounded-lg shadow-md hover:bg-gray-800 transition duration-300">
        Add Category
      </button>
    </form>
  </div>
</section>
</body>
</html>

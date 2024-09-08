<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recover Password - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .card {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1), 0 2px 6px rgba(0, 0, 0, 0.05);
        }
        .btn-primary {
            background-color: #000000; /* Black */
            color: #ffffff;
        }
        .btn-primary:hover {
            background-color: #1a1a1a; /* Slightly lighter black */
        }
        .text-error {
            color: #ef4444; /* Red-500 */
        }
        .error-message {
            display: none; /* Initially hidden */
        }
        .error-visible {
            display: block; /* Displayed when there is an error */
        }
        body {
            background: linear-gradient(135deg, #f8fafc, #e5e7eb); /* Light gray gradient background */
        }
    </style>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
<div class="card bg-white p-8 rounded-xl max-w-lg w-full">
    <h1 class="text-3xl font-bold mb-6 text-center text-gray-900">Recover Your Password</h1>

    <!-- Display error message if it exists -->
    <div class="bg-red-100 text-red-700 p-4 rounded-lg mb-6 text-center error-message <% if (request.getAttribute("errorMessage") != null) { %> error-visible <% } %>">
        <%= request.getAttribute("errorMessage") %>
    </div>

    <!-- Display success message if it exists -->
    <div class="bg-green-100 text-green-700 p-4 rounded-lg mb-6 text-center error-message <% if (request.getAttribute("message") != null) { %> error-visible <% } %>">
        <%= request.getAttribute("message")  %>
    </div>

    <form action="/controller/recover-password" method="post" class="space-y-6">
        <div>
            <label for="email" class="block text-gray-700 text-sm font-medium mb-2">Email Address</label>
            <input type="email" id="email" name="email" required
                   class="shadow-sm border border-gray-300 rounded-lg w-full py-3 px-4 text-gray-700 leading-tight focus:outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-500 transition duration-150 ease-in-out">
        </div>
        <button type="submit"
                class="w-full btn-primary py-3 px-4 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50 transition duration-150 ease-in-out">
            Send Recovery Link
        </button>
        <div class="text-center mt-6">
            <a href="/auth/user/login" class="text-gray-700 hover:text-gray-900 text-sm font-medium">Back to Login</a>
        </div>
    </form>
</div>
</body>
</html>

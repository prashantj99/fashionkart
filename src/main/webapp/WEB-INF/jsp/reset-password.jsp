<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .error-message {
            display: none; /* Initially hidden */
        }
        .error-visible {
            display: block; /* Displayed when there is an error */
        }
        body {
            background: linear-gradient(135deg, #f8fafc, #e5e7eb);
        }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen">
<div class="bg-white p-8 rounded-2xl shadow-lg w-full max-w-lg">
    <h2 class="text-3xl font-extrabold mb-6 text-gray-900 text-center">Reset Your Password</h2>

    <!-- Error message -->
    <div class="bg-red-100 text-red-700 p-4 rounded-lg mb-6 text-center error-message <% if (request.getAttribute("errorMessage") != null) { %> error-visible <% } %>">
        <%= request.getAttribute("errorMessage") %>
    </div>

    <!-- Success message -->
    <div class="bg-green-100 text-green-700 p-4 rounded-lg mb-6 text-center error-message <% if (request.getAttribute("message") != null) { %> error-visible <% } %>">
        <%= request.getAttribute("message") %>
    </div>

    <form action="/controller/reset-password" method="post" class="space-y-6">
        <input type="hidden" name="token" value="${param.token}">
        <div>
            <label for="password" class="block text-sm font-medium text-gray-700">New Password</label>
            <input type="password" name="password" id="password" class="mt-1 block w-full border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm py-3 px-4" required>
        </div>
        <div>
            <label for="confirmPassword" class="block text-sm font-medium text-gray-700">Confirm Password</label>
            <input type="password" name="confirmPassword" id="confirmPassword" class="mt-1 block w-full border border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm py-3 px-4" required>
        </div>
        <button type="submit" class="w-full bg-black text-white py-3 rounded-lg font-medium hover:bg-gray-800 transition duration-150 ease-in-out">
            Reset Password
        </button>
    </form>
    <div class="mt-6 text-center">
        <p class="text-gray-600">Remember your password?
            <a href="/auth/user/login" class="text-blue-500 font-semibold hover:underline">Back to Sign In</a>
        </p>
    </div>
</div>
</body>
</html>

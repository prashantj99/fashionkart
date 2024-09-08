<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored='false' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enter Email - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .btn-primary {
            background-color: #000000; /* Black */
            color: #FFFFFF;
        }
        .btn-primary:hover {
            background-color: #333333; /* Dark Gray */
        }
        .text-error {
            color: #DC2626; /* Red-600 */
        }
        .bg-primary {
            background-color: #FFFFFF; /* White */
        }
        .text-primary {
            color: #000000; /* Black */
        }
    </style>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
<div class="w-full max-w-md p-8 bg-white shadow-lg rounded-lg">
    <h1 class="text-3xl font-bold text-gray-800 mb-6 text-center">Enter Your Email</h1>
    <form action="/controller/send-otp" method="post" class="space-y-4">
        <div>
            <label for="email" class="block text-gray-700 font-medium mb-2">Email</label>
            <input type="email" id="email" name="email"
                   class="w-full px-4 py-2 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
                   placeholder="Enter your email" required>
        </div>

        <button type="submit" class="w-full px-4 py-2 btn-primary font-bold rounded-lg shadow-md hover:bg-gray-800 transition">Send OTP</button>
    </form>

    <!-- Display error message if present -->
    <c:if test="${not empty errorMessage}">
        <div class="mt-4 bg-red-100 text-error p-4 rounded-lg text-center">
                ${errorMessage}
        </div>
    </c:if>
</div>
</body>
</html>

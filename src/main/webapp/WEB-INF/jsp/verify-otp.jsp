<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .btn-primary {
            background-color: #000000; /* Black */
            color: #FFFFFF;
        }
        .btn-primary:hover {
            background-color: #333333; /* Dark Gray */
        }
        .bg-error {
            background-color: #FEE2E2; /* Red-100 */
        }
        .text-error {
            color: #DC2626; /* Red-600 */
        }
    </style>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
<div class="w-full max-w-md p-8 bg-white shadow-lg rounded-lg">
    <h1 class="text-3xl font-extrabold mb-6 text-gray-800 text-center">Verify OTP</h1>

    <!-- Display error message if present -->
    <c:if test="${not empty errorMessage}">
        <div class="mb-4 bg-error text-error p-4 rounded-lg text-center">
                ${errorMessage}
        </div>
    </c:if>

    <form action="/controller/verify-otp" method="post" class="space-y-6">
        <div>
            <label for="otp" class="block text-gray-700 font-medium mb-2">Enter OTP</label>
            <input type="text" id="otp" name="otp"
                   class="w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                   placeholder="Enter the OTP sent to your email"
                   required>
            <input type="hidden" name="email" value="${email}">
        </div>
        <button type="submit" class="w-full px-4 py-2 btn-primary font-semibold rounded-lg shadow-md hover:bg-gray-800 transition">Verify OTP</button>
    </form>
</div>
</body>
</html>

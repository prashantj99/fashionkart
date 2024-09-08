<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .btn-primary {
            background-color: #000000; /* Black */
            color: #FFFFFF;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #1F2937; /* Cool Gray 800 */
        }
    </style>
</head>
<body class="font-sans bg-gray-50 flex items-center justify-center min-h-screen">

<div class="w-full max-w-sm bg-white p-8 rounded-xl shadow-lg">
    <h2 class="text-3xl font-extrabold text-center text-gray-900 mb-6">Sign in to your account</h2>

    <% if (request.getAttribute("errorMessage") != null) { %>
    <div class="mb-4 bg-red-100 text-red-700 p-4 rounded-lg">
        <%= request.getAttribute("errorMessage") %>
    </div>
    <% } %>

    <form action="/controller/seller-login" method="post" class="space-y-6">
        <div>
            <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
            <div class="mt-1">
                <input type="email" id="email" name="email" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent" placeholder="you@example.com" required>
            </div>
        </div>
        <div>
            <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
            <div class="mt-1">
                <input type="password" id="password" name="password" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent" placeholder="••••••••" required>
            </div>
        </div>
        <button type="submit" class="btn-primary w-full py-2 rounded-lg text-sm font-medium text-center">Sign In</button>
    </form>

    <div class="mt-6 text-center text-sm">
        <p class="text-gray-500">Don't have an account?
            <a href="/auth/sellers/register" class="text-indigo-600 font-semibold hover:underline">Sign Up</a>
        </p>
    </div>
    <div class="mt-4 text-center text-sm">
        <p class="text-gray-500">Forgot your password?
            <a href="/auth/forgot-password/recover-password" class="text-indigo-600 font-semibold hover:underline">Recover it</a>
        </p>
    </div>
</div>

</body>
</html>

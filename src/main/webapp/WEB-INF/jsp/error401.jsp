<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>401 - Unauthorized</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
<div class="bg-white p-8 rounded-lg shadow-lg max-w-md w-full text-center">
    <div class="flex justify-center mb-4">
        <svg class="w-16 h-16 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12h2a2 2 0 012 2v4a2 2 0 01-2 2H6a2 2 0 01-2-2v-4a2 2 0 012-2h2M12 11V9m0-4h.01"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v-1m6 4v1a2 2 0 01-2 2H8a2 2 0 01-2-2v-1m6-7V5m0 4h.01M10 12h4"></path></svg>
    </div>
    <h1 class="text-3xl font-extrabold text-red-600 mb-4">401 - Unauthorized</h1>
    <p class="text-gray-700 mb-6">You are not authorized to view this page. Please log in and try again.</p>
    <a href="/auth/user/login" class="inline-block px-6 py-3 text-white bg-blue-500 hover:bg-blue-600 rounded-full transition duration-300">Login</a>
</div>
</body>
</html>

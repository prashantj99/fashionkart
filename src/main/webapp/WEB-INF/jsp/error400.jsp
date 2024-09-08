<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>400 - Bad Request</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
<div class="bg-white p-8 rounded-lg shadow-lg max-w-md w-full text-center">
    <div class="flex justify-center mb-4">
        <svg class="w-16 h-16 text-yellow-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m0-4h.01M12 2a10 10 0 100 20 10 10 0 000-20z"></path></svg>
    </div>
    <h1 class="text-3xl font-extrabold text-yellow-500 mb-4">400 - Bad Request</h1>
    <p class="text-gray-700 mb-6">The request could not be understood by the server due to malformed syntax. Please check the request and try again.</p>
    <a href="/index" class="inline-block px-6 py-3 text-white bg-blue-500 hover:bg-blue-600 rounded-full transition duration-300">Return to Home</a>
</div>
</body>
</html>

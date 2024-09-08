<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Not Found</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
<div class="bg-white p-8 rounded-lg shadow-lg max-w-md w-full text-center">
    <div class="flex justify-center mb-4">
        <svg class="w-16 h-16 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.75 17l.75-4.5L15.75 7.5l-4.5.75L7.5 14.25l.75 4.5z"></path></svg>
    </div>
    <h1 class="text-3xl font-extrabold text-blue-600 mb-4">404 - Page Not Found</h1>
    <p class="text-gray-700 mb-6">The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.</p>
    <a href="/index" class="inline-block px-6 py-3 text-white bg-blue-500 hover:bg-blue-600 rounded-full transition duration-300">Return to Home</a>
</div>
</body>
</html>

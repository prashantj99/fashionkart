<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .bg-pattern {
            background-image: url('https://www.transparenttextures.com/patterns/diamond-upholstery.png');
            background-color: #f3f4f6;
        }
    </style>
</head>
<body class="bg-pattern flex items-center justify-center min-h-screen">
<div class="bg-white p-8 rounded-lg shadow-lg max-w-md w-full text-center">
    <div class="flex justify-center mb-4">
        <svg class="w-16 h-16 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 5.636a9 9 0 111.414 1.414l-1.414-1.414z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01"></path></svg>
    </div>
    <h1 class="text-3xl font-extrabold text-red-600 mb-4">Oops! Something went wrong.</h1>
    <p class="text-gray-700 mb-6">We encountered an error while processing your request. Please try again later or contact support if the issue persists.</p>
    <a href="/index" class="inline-block px-6 py-3 text-white bg-blue-500 hover:bg-blue-600 rounded-full transition duration-300">Return to Home</a>
</div>
</body>
</html>

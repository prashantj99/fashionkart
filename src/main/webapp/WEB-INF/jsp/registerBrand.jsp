<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Your Brand - FashionKart</title>
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
<body class="font-sans bg-gray-100">
<section class="py-16">
    <div class="container mx-auto max-w-lg bg-white p-8 rounded-lg shadow-lg">
        <h3 class="text-3xl font-bold mb-6 text-primary">Register Your Brand</h3>
        <!-- Display server-side error message if any -->
        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="mb-4 bg-red-100 text-red-700 p-4 rounded-lg">
            <%= request.getAttribute("errorMessage") %>
        </div>
        <% } %>
        <form action="/controller/brand-register" method="post">
            <div class="mb-4">
                <label for="brandName" class="block text-secondary text-lg font-medium mb-1">Brand Name</label>
                <input type="text" id="brandName" name="brandName" class="w-full px-4 py-2 border border-primary rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" required>
            </div>
            <div class="mb-4">
                <label for="email" class="block text-secondary text-lg font-medium mb-1">Email</label>
                <input type="email" id="email" name="email" class="w-full px-4 py-2 border border-primary rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" required>
            </div>
            <div class="mb-4">
                <label for="password" class="block text-secondary text-lg font-medium mb-1">Password</label>
                <input type="password" id="password" name="password" class="w-full px-4 py-2 border border-primary rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" required>
            </div>
            <div class="mb-4">
                <label for="description" class="block text-secondary text-lg font-medium mb-1">Description</label>
                <textarea id="description" name="description" class="w-full px-4 py-2 border border-primary rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" rows="3"></textarea>
            </div>
            <div class="mb-4">
                <label for="logoUrl" class="block text-secondary text-lg font-medium mb-1">Logo URL</label>
                <input type="text" id="logoUrl" name="logoUrl" class="w-full px-4 py-2 border border-primary rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
            </div>
            <div class="mb-4">
                <label for="contactNumber" class="block text-secondary text-lg font-medium mb-1">Contact Number</label>
                <input type="text" id="contactNumber" name="contactNumber" class="w-full px-4 py-2 border border-primary rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
            </div>
            <div class="mb-4">
                <label for="websiteUrl" class="block text-secondary text-lg font-medium mb-1">Website URL</label>
                <input type="text" id="websiteUrl" name="websiteUrl" class="w-full px-4 py-2 border border-primary rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
            </div>
            <div class="mb-4">
                <label for="facebookUrl" class="block text-secondary text-lg font-medium mb-1">Facebook URL</label>
                <input type="text" id="facebookUrl" name="facebookUrl" class="w-full px-4 py-2 border border-primary rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
            </div>
            <div class="mb-4">
                <label for="instagramUrl" class="block text-secondary text-lg font-medium mb-1">Instagram URL</label>
                <input type="text" id="instagramUrl" name="instagramUrl" class="w-full px-4 py-2 border border-primary rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
            </div>
            <div class="mb-4">
                <label for="twitterUrl" class="block text-secondary text-lg font-medium mb-1">Twitter URL</label>
                <input type="text" id="twitterUrl" name="twitterUrl" class="w-full px-4 py-2 border border-primary rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
            </div>
            <button type="submit" class="w-full px-4 py-2 btn-primary font-semibold rounded-lg shadow-md hover:bg-gray-800 transition duration-300">Register</button>
        </form>
        <div class="mt-6 text-center">
            <p class="text-gray-600">Already have an account?
                <a href="/auth/brand/login" class="text-blue-500 font-semibold hover:underline">Sign In</a>
            </p>
        </div>

        <div class="mt-6 text-center">
            <p class="text-gray-600">Forgot Password?
                <a href="/auth/forgot-password/recover-password" class="text-blue-500 font-semibold hover:underline">click here</a>
            </p>
        </div>
    </div>
</section>

</body>
</html>

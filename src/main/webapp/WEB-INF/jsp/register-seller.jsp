<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Seller - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .btn-primary {
            background-color: #000000; /* Black */
            color: white;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #333333; /* Dark Gray */
        }

        .text-primary {
            color: #000000; /* Tailwind's black */
        }

        .text-secondary {
            color: #6b7280; /* Tailwind's gray-500 */
        }

        .input-error {
            border-color: #ef4444; /* Tailwind's red-500 */
        }

        .error-message {
            color: #ef4444; /* Tailwind's red-500 */
        }
    </style>
</head>
<body class="bg-gray-50">

<section class="py-10">
    <div class="container mx-auto max-w-lg bg-white p-10 rounded-xl shadow-lg">
        <h2 class="text-3xl font-extrabold text-center mb-8 text-primary">Create Your Seller Account</h2>

        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="mb-4 bg-red-100 text-red-700 p-4 rounded-lg">
            <%= request.getAttribute("errorMessage") %>
        </div>
        <% } %>

        <form action="/controller/seller-register" method="post" class="space-y-6">
            <div>
                <label for="name" class="block text-sm font-medium text-secondary">Name</label>
                <input type="text" id="name" name="name"
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                       required>
            </div>
            <div>
                <label for="email" class="block text-sm font-medium text-secondary">Email</label>
                <input type="email" id="email" name="email"
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                       required>
            </div>
            <div>
                <label for="password" class="block text-sm font-medium text-secondary">Password</label>
                <input type="password" id="password" name="password"
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                       required>
            </div>
            <div>
                <label for="description" class="block text-sm font-medium text-secondary">Description</label>
                <textarea id="description" name="description"
                          class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                          rows="4"></textarea>
            </div>
            <div>
                <label for="phoneNumber" class="block text-sm font-medium text-secondary">Phone Number</label>
                <input type="text" id="phoneNumber" name="phoneNumber"
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
            </div>
            <div>
                <label for="businessName" class="block text-sm font-medium text-secondary">Business Name</label>
                <input type="text" id="businessName" name="businessName"
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
            </div>
            <div>
                <label for="businessAddress" class="block text-sm font-medium text-secondary">Business Address</label>
                <input type="text" id="businessAddress" name="businessAddress"
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
            </div>
            <div>
                <label for="supportEmail" class="block text-sm font-medium text-secondary">Support Email</label>
                <input type="email" id="supportEmail" name="supportEmail"
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
            </div>
            <div>
                <label for="supportContact" class="block text-sm font-medium text-secondary">Support Contact</label>
                <input type="text" id="supportContact" name="supportContact"
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
            </div>
            <button type="submit" class="btn-primary w-full py-2 rounded-lg text-sm font-medium text-center">Register
            </button>
        </form>

        <div class="mt-6 text-center">
            <p class="text-gray-600">Already have an account?
                <a href="/auth/sellers/login" class="text-blue-500 font-semibold hover:underline">Sign In</a>
            </p>
        </div>

        <div class="mt-6 text-center">
            <p class="text-gray-600">Forgot Password?
                <a href="/auth/forgot-password/recover-password" class="text-blue-500 font-semibold hover:underline">Click
                    here</a>
            </p>
        </div>
    </div>
</section>
</body>
</html>

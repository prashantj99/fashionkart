<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to FashionKart Brands</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        /* Custom styles for modern UI/UX */
        .hero-section {
            background: linear-gradient(to bottom, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.7)), url('https://images.unsplash.com/photo-1600445868920-61630a8dfd27');
            background-size: cover;
            background-position: center;
        }
        .btn-primary {
            background-color: #3490dc; /* Primary Blue */
            color: #ffffff;
        }
        .btn-primary:hover {
            background-color: #2779bd; /* Darker Blue */
        }
        .btn-secondary {
            background-color: #ffffff;
            color: #3490dc; /* Primary Blue */
            border: 2px solid #3490dc; /* Primary Blue */
        }
        .btn-secondary:hover {
            background-color: #f3f4f6; /* Light Gray */
            border-color: #2779bd; /* Darker Blue */
        }
    </style>
</head>
<body class="font-sans bg-gray-100">

<!-- Navbar -->
<nav class="bg-white shadow-md p-4">
    <div class="container mx-auto flex items-center justify-between">
        <a href="#" class="text-blue-600 text-2xl font-bold">FashionKart</a>
        <div>
            <a href="/auth/brand/register" class="btn-secondary px-6 py-2 rounded-lg text-lg font-semibold mx-2 hover:bg-gray-100">Register</a>
            <a href="/auth/brand/login" class="btn-primary px-6 py-2 rounded-lg text-lg font-semibold mx-2 hover:bg-blue-700">Login</a>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-section h-screen flex items-center justify-center text-center text-white bg-opacity-70">
    <div class="bg-black bg-opacity-50 p-10 rounded-lg shadow-lg">
        <h1 class="text-4xl md:text-6xl font-bold mb-6">Welcome to FashionKart</h1>
        <p class="text-lg md:text-xl mb-8">Where brands meet their audience. Showcase your products and grow your business with us.</p>
        <a href="registerBrand.jsp" class="btn-primary inline-block px-8 py-4 font-semibold rounded-lg shadow-md hover:bg-blue-700 transition duration-300">Get Started</a>
    </div>
</section>

<!-- Features Section -->
<section id="features" class="py-16 bg-gray-200">
    <div class="container mx-auto text-center">
        <h2 class="text-3xl font-bold mb-12 text-blue-600">Why Choose FashionKart?</h2>
        <div class="flex flex-wrap justify-center">
            <div class="bg-white p-8 rounded-lg shadow-md mx-4 mb-8 w-full md:w-1/3">
                <h3 class="text-2xl font-semibold mb-4 text-blue-600">Easy Registration</h3>
                <p class="text-gray-700">Quick and simple registration process to get your brand online in no time.</p>
            </div>
            <div class="bg-white p-8 rounded-lg shadow-md mx-4 mb-8 w-full md:w-1/3">
                <h3 class="text-2xl font-semibold mb-4 text-blue-600">Customizable Storefront</h3>
                <p class="text-gray-700">Personalize your brand's storefront with our easy-to-use tools and templates.</p>
            </div>
            <div class="bg-white p-8 rounded-lg shadow-md mx-4 mb-8 w-full md:w-1/3">
                <h3 class="text-2xl font-semibold mb-4 text-blue-600">Advanced Analytics</h3>
                <p class="text-gray-700">Track your performance with advanced analytics and grow your business effectively.</p>
            </div>
        </div>
    </div>
</section>

<!-- Contact Section -->
<section id="contact" class="py-16 bg-gray-100">
    <div class="container mx-auto text-center">
        <h2 class="text-3xl font-bold mb-6 text-blue-600">Get in Touch</h2>
        <p class="text-lg mb-8">Have questions or need assistance? We're here to help. Reach out to us anytime.</p>
        <a href="mailto:support@fashionkart.com" class="btn-primary inline-block px-8 py-4 font-semibold rounded-lg shadow-md hover:bg-blue-700 transition duration-300">Contact Us</a>
    </div>
</section>

<!-- Footer -->
<footer class="bg-gray-800 text-white py-6">
    <div class="container mx-auto text-center">
        <p>&copy; 2024 FashionKart. All rights reserved.</p>
        <p>123 Fashion Street, Suite 456, City, Country</p>
        <p><a href="mailto:support@fashionkart.com" class="text-blue-400 hover:underline">support@fashionkart.com</a></p>
    </div>
</footer>

</body>
</html>

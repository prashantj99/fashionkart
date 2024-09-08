<%@ page isELIgnored="false" %>
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
        <h3 class="text-3xl font-bold mb-6 text-primary">Login</h3>
        <!-- Display server-side error message if any -->
        <c:if test="${not empty errorMessage}">
            <div class="mb-4 bg-red-100 text-red-700 p-4 rounded-lg">
                    ${errorMessage}
            </div>
        </c:if>
        <form action="/controller/brand-login" method="post">
            <div class="mb-4">
                <label for="email" class="block text-secondary text-lg font-medium mb-1">Email</label>
                <input type="email" id="email" name="email"
                       class="w-full px-4 py-2 border border-primary rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                       required>
            </div>
            <div class="mb-4">
                <label for="password" class="block text-secondary text-lg font-medium mb-1">Password</label>
                <input type="password" id="password" name="password"
                       class="w-full px-4 py-2 border border-primary rounded-lg focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                       required>
            </div>
            <button type="submit"
                    class="w-full px-4 py-2 btn-primary font-semibold rounded-lg shadow-md hover:bg-gray-800 transition duration-300">
                Login
            </button>
        </form>
        <div class="mt-6 text-center">
            <p class="text-gray-600">Don't have an account?
                <a href="/auth/brand/register" class="text-blue-500 font-semibold hover:underline">Sign Up</a>
            </p>
        </div>

        <div class="mt-6 text-center">
            <p class="text-gray-600">Forgot Password?
                <a href="/auth/forgot-password/recover-password" class="text-blue-500 font-semibold hover:underline">click
                    here</a>
            </p>
        </div>
    </div>
</section>

</body>
</html>

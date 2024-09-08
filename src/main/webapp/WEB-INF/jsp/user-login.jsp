<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .error-message {
            display: none; /* Initially hidden */
        }
        .error-visible {
            display: block; /* Displayed when there is an error */
        }
    </style>
</head>
<body class="bg-gradient-to-r from-gray-100 to-gray-300 flex items-center justify-center min-h-screen">

<div class="bg-white shadow-2xl rounded-xl p-10 w-full max-w-lg transform transition-all duration-500 hover:scale-105">
    <h2 class="text-4xl font-extrabold text-gray-900 text-center mb-8">Sign In</h2>

    <!-- Display error message only if it exists -->
    <div class="bg-red-100 text-red-700 p-4 rounded mb-6 text-center error-message <% if (request.getAttribute("errorMessage") != null) { %> error-visible <% } %>">
        <%= request.getAttribute("errorMessage") %>
    </div>

    <form action="/controller/user-login" method="post" class="space-y-7">

        <div>
            <label for="loginType" class="block text-gray-700 font-semibold mb-2">Login with</label>
            <select id="loginType" name="loginType" class="w-full p-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-black focus:border-transparent">
                <option value="username">Username</option>
                <option value="email">Email</option>
            </select>
        </div>

        <div>
            <label for="usernameoremail" class="block text-gray-700 font-semibold mb-2">Username or Email</label>
            <input id="usernameoremail" name="usernameoremail" type="text" required class="w-full p-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-black focus:border-transparent" placeholder="Enter your username or email">
        </div>

        <div>
            <label for="password" class="block text-gray-700 font-semibold mb-2">Password</label>
            <input id="password" name="password" type="password" required class="w-full p-4 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-black focus:border-transparent" placeholder="Enter your password">
        </div>

        <button type="submit" class="w-full bg-black text-white p-4 rounded-lg font-semibold hover:bg-gray-800 transition duration-300">Login</button>
    </form>

    <div class="mt-8 text-center">
        <p class="text-gray-600">Don't have an account?
            <a href="/auth/user/register/email" class="text-black font-semibold hover:underline">Sign Up</a>
        </p>
    </div>

    <div class="mt-6 text-center">
        <p class="text-gray-600">Forgot Password?
            <a href="/auth/forgot-password/recover-password" class="text-black font-semibold hover:underline">Click Here</a>
        </p>
    </div>
</div>

</body>
<script defer>
    document.querySelector("#loginType").onchange = ()=>{
        let type = this.value();
        document.querySelector('#username').toggleClass('hide');
        document.querySelector('#email').toggleClass('hide');
    }

</script>
</html>

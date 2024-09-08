<!-- Header -->
<header class="bg-white shadow sticky top-0 z-50">
    <nav class="container mx-auto p-4 flex justify-between items-center">
        <a href="/index" class="text-xl font-semibold text-gray-700">FashionKart</a>
        <ul class="flex space-x-4">
            <% if(loggedInUser != null){%>
            <li>
                <a href="/user/cart" class="text-gray-600 hover:text-gray-900">
                    <img width="24" height="24" src="https://img.icons8.com/skeuomorphism/32/shopping-cart.png" alt="shopping-cart"/>
                </a>
            </li>
            <li>
                <a href="/user/wishlist" class="text-gray-600 hover:text-gray-900">
                    <img width="24" height="24"
                         src="https://img.icons8.com/external-sbts2018-flat-sbts2018/58/external-wishlist-ecommerce-basic-1-sbts2018-flat-sbts2018.png"
                         alt="external-wishlist-ecommerce-basic-1-sbts2018-flat-sbts2018"/>
                </a>
            </li>
            <li>
                <a href="account.jsp" class="text-gray-600 hover:text-gray-900">
                    <img width="24" height="24" src="https://img.icons8.com/fluency-systems-filled/50/guest-male.png" alt="guest-male"/>
                </a>
            </li>
            <li>
                <a href="/controller/logout" class="text-gray-600 hover:text-gray-900">
                    <img width="24" height="24" src="https://img.icons8.com/ios/50/shutdown--v1.png" alt="shutdown--v1"/>
                </a>
            </li>
            <%} else {%>
            <li><a href="/auth/user/login" class="text-gray-600 hover:text-gray-900">Login</a></li>
            <li><a href="/auth/user/register/email" class="text-gray-600 hover:text-gray-900">Signup</a></li>
            <%}%>
        </ul>
    </nav>
</header>
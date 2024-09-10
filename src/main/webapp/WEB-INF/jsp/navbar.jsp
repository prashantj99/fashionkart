<%@page import="com.fashionkart.utils.*" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<header class="bg-white shadow sticky top-0 z-50">
    <nav class="container mx-auto p-4 flex justify-between items-center">
        <a href="/index" class="flex cursor-pointer items-center whitespace-nowrap text-2xl font-light">
              <span class="mr-2 text-4xl text-blue-500">
                <svg height="24px" id="Layer_1" viewBox="0 0 48 48" width="48px"
                     xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path
                        clip-rule="evenodd"
                        d="M43,46H5c-2.209,0-4-1.791-4-4l4-24c0.678-3.442,2.668-4,4.877-4h2.652  C14.037,7.052,18.602,2,24,2s9.963,5.052,11.471,12h2.652c2.209,0,4.199,0.558,4.877,4l4,24C47,44.209,45.209,46,43,46z M24,4  c-4.352,0-8.045,4.178-9.418,10h18.837C32.045,8.178,28.353,4,24,4z M41,18c-0.308-1.351-0.957-2-2.37-2h-2.828  C35.925,16.976,36,17.975,36,19c0,0.552-0.447,1-1,1s-1-0.448-1-1c0-1.027-0.069-2.031-0.201-3H14.201C14.07,16.969,14,17.973,14,19  c0,0.552-0.447,1-1,1s-1-0.448-1-1c0-1.025,0.075-2.024,0.197-3H9.369C7.957,16,7.309,16.649,7,18L3,42c0,1.104,0.896,2,2,2h38  c1.104,0,2-0.896,2-2L41,18z"
                        fill-rule="evenodd"></path></svg>
              </span>
            FashionKart
        </a>
        <ul class="flex space-x-4 gap-2">
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
                <a href="/user/account" class="text-gray-600 hover:text-gray-900">
                    <img
                         class="rounded-full object-cover h-8 w-8"
                         src="<%=loggedInUser.getImage().startsWith("default") ? "https://img.icons8.com/ios-filled/50/user.png" : FirebaseStorageUtil.generateSignedUrl(loggedInUser.getImage())%>"
                         alt="guest-male"/>
                </a>
            </li>
            <li>
                <a href="/controller/logout" class="text-gray-600 hover:text-gray-900">
                    <img width="24" height="24" src="https://img.icons8.com/ios/50/shutdown--v1.png" alt="shutdown--v1"/>
                </a>
            </li>
            <%} else {%>
            <li><a href="/welcome/brand" class="text-gray-600 hover:text-gray-900">Brand</a></li>
            <li><a href="/auth/sellers/login" class="text-gray-600 hover:text-gray-900">Merchant</a></li>
            <li><a href="/auth/user/login" class="text-gray-600 hover:text-gray-900">Login</a></li>
            <li><a href="/auth/user/register/email" class="text-gray-600 hover:text-gray-900">Signup</a></li>
            <%}%>
        </ul>
    </nav>
</header>
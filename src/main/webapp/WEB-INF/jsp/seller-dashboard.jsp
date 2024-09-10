<%@ page import="com.fashionkart.utils.Constants" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50">
<div class="flex w-full bg-gray-200 gap-5">
    <div class="bg-gray-50 relative">
        <!-- Sidebar -->
        <div class="fixed left-0 flex h-screen w-72 flex-col overflow-hidden rounded-r-2xl bg-gray-700 text-white">
            <h1 class="mt-10 ml-10 text-3xl font-bold">FashionKart</h1>
            <ul class="mt-20 space-y-3">
                <li class="relative flex cursor-pointer space-x-2 rounded-md py-4 px-10 text-gray-300 hover:bg-slate-600">
                    <span>
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                             stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round"
                              d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path>
                        </svg>
                    </span>
                    <a class="<%="addProduct".equals(request.getParameter("action")) ?  "text-gray-100" : "text-gray-500" %>"
                       href="<%= Constants.ACTION_ADD_PRODUCT %>">Product Addition</a>
                </li>
                <li class="relative flex cursor-pointer space-x-2 rounded-md py-4 px-10 font-semibold hover:bg-slate-600">
                    <span>
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                             stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round"
                              d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path>
                        </svg>
                    </span>
                    <a class="<%="addCategory".equals(request.getParameter("action")) ?  "text-gray-100" : "text-gray-500" %>"
                       href="<%= Constants.ACTION_ADD_CATEGORY %>">Category Addition</a>
                </li>
                <li class="relative flex cursor-pointer space-x-2 rounded-md py-4 px-10 text-gray-300 hover:bg-slate-600">
                    <span>
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                             stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                  d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"></path>
                        </svg>
                    </span>
                    <a class="<%="addDiscount".equals(request.getParameter("action")) ?  "text-gray-100" : "text-gray-500" %>"
                       href="<%= Constants.ACTION_ADD_DISCOUNT %>">Discount</a>
                </li>
                <li class="relative flex cursor-pointer space-x-2 rounded-md py-4 px-10 text-gray-300 hover:bg-slate-600">
                    <span>
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                             stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                  d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path>
                        </svg>
                    </span>
                    <a class="<%="manageDiscounts".equals(request.getParameter("action")) ?  "text-gray-100" : "text-gray-500" %>"
                       href="<%= Constants.ACTION_MANAGE_DISCOUNTS %>">Manage Discount</a>
                </li>
                <li class="relative flex cursor-pointer space-x-2 rounded-md py-4 px-10 text-gray-300 hover:bg-slate-600">
                    <span>
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                             stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round"
                              d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"></path>
                        </svg>
                    </span>
                    <a class="<%="salesAnalytics".equals(request.getParameter("action")) ?  "text-gray-100" : "text-gray-500" %>"
                       href="<%= Constants.ACTION_SALES_ANALYTICS %>">Sales Analytics</a>
                </li>
                <li class="relative flex cursor-pointer space-x-2 rounded-md py-4 px-10 text-gray-300 hover:bg-slate-600">
                <span>
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                         stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round"
                              d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path>
                        <path stroke-linecap="round" stroke-linejoin="round"
                              d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                    </svg>
                </span>
                    <a class="<%="manageProducts".equals(request.getParameter("action")) ?  "text-gray-100" : "text-gray-500" %>"
                       href="<%= Constants.ACTION_MANAGE_PRODUCTS %>">Stocks Info</a>
                </li>
            </ul>

            <div class="my-6 mt-auto ml-10 flex cursor-pointer text-left">
                <form action="/controller/logout" method="post" class="flex justify-center items-center gap-3">
                    <button type="submit" class="btn-primary">
                        <span>
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                                 stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                  d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4"></path></svg>
                        </span>
                    </button>
                    <label for="lg" class="text-gray-100">Logout</label>
                    <input id="lg" hidden="hidden" type="text">
                </form>
            </div>
        </div>
        <!-- /Sidebar -->
    </div>

</div>
<!-- Main Layout -->
<div class="flex w-full h-screen">
    <!-- Main Content Area -->
    <div class="flex-grow ml-64 p-10">
        <!-- Dynamically include JSP based on action -->
        <%
            String action = request.getParameter("action");
            String includePage = "/sellers/add/product";

            if ("addProduct".equals(action)) {
                includePage = Constants.URL_ADD_PRODUCT;
            } else if ("addCategory".equals(action)) {
                includePage = Constants.URL_ADD_CATEGORY;
            } else if ("manageProducts".equals(action)) {
                includePage = Constants.URL_MANAGE_PRODUCTS;
            } else if ("salesAnalytics".equals(action)) {
                includePage = Constants.URL_SALES_ANALYTICS;
            } else if ("addDiscount".equals(action)) {
                includePage = Constants.URL_ADD_DISCOUNT;
            } else if ("manageDiscounts".equals(action)) {
                includePage = Constants.URL_MANAGE_DISCOUNTS;
            }
        %>

        <jsp:include page="<%= includePage %>"/>
    </div>
</div>

</body>
</html>

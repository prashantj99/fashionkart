<%@ page import="com.fashionkart.service.SellerService" %>
<%@ page import="com.fashionkart.serviceimpl.SellerServiceImpl" %>
<html>
<head>
    <title>Admin Dashboard - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body class="bg-gray-100 vsc-initialized">
<!-- Sidebar -->
<%
    SellerService sellerService = new SellerServiceImpl();
%>
<div class="flex w-full">
    <%@include file="admin-sidebar.jsp" %>
    <!-- Main Content -->
    <div class="ml-64 p-8 w-full">
        <h1 class="text-2xl font-bold mb-6">Welcome to Admin Dashboard</h1>
        <div class="bg-white p-8 rounded shadow-lg">
            <p>Dashboard overview, analytics, and many more...</p>
        </div>
        <div class="m-10 grid gap-5 sm:grid-cols-3 mx-auto max-w-screen-lg">
            <div class="px-4 py-6 shadow-lg shadow-blue-100">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-14 w-14 rounded-xl bg-blue-50 p-4 text-blue-300"
                     viewBox="0 0 20 20" fill="currentColor">
                    <path d="M10 12a2 2 0 100-4 2 2 0 000 4z"></path>
                    <path fill-rule="evenodd"
                          d="M.458 10C1.732 5.943 5.522 3 10 3s8.268 2.943 9.542 7c-1.274 4.057-5.064 7-9.542 7S1.732 14.057.458 10zM14 10a4 4 0 11-8 0 4 4 0 018 0z"
                          clip-rule="evenodd"></path>
                </svg>
                <p class="mt-4 font-medium">Sellers</p>
                <p class="mt-2 text-xl font-medium"> <%=sellerService.totalSellers()%>
                    <svg xmlns="http://www.w3.org/2000/svg" class="inline h-4 w-4" fill="none" viewBox="0 0 24 24"
                         stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M5 10l7-7m0 0l7 7m-7-7v18"></path>
                    </svg>
                </p>
                <span class="text-xs text-gray-400">+<%=sellerService.calculateSellerGrowthPercentage()%>%</span>
            </div>
            <div class="px-4 py-6 shadow-lg shadow-blue-100">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-14 w-14 rounded-xl bg-rose-50 p-4 text-rose-300"
                     viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z"
                          clip-rule="evenodd"></path>
                </svg>
                <p class="mt-4 font-medium">Users</p>
                <p class="mt-2 text-xl font-medium"> 23.4k
                    <svg xmlns="http://www.w3.org/2000/svg" class="inline h-4 w-4" fill="none" viewBox="0 0 24 24"
                         stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M5 10l7-7m0 0l7 7m-7-7v18"></path>
                    </svg>
                </p>
                <span class="text-xs text-gray-400">+4.9%</span>
            </div>
            <div class="px-4 py-6 shadow-lg shadow-blue-100">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-14 w-14 rounded-xl bg-green-50 p-4 text-green-300"
                     fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round"
                          d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
                <p class="mt-4 font-medium">Revenue</p>
                <p class="mt-2 text-xl font-medium"> $23.4k
                    <svg xmlns="http://www.w3.org/2000/svg" class="inline h-4 w-4" fill="none" viewBox="0 0 24 24"
                         stroke="currentColor" stroke-width="2">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M5 10l7-7m0 0l7 7m-7-7v18"></path>
                    </svg>
                </p>
                <span class="text-xs text-gray-400">+4.9%</span>
            </div>
        </div>
        <div class="bg-gradient-to-r from-blue-600 to-indigo-500">
            <div class="mx-auto h-100 px-4 py-10 sm:max-w-xl md:max-w-full md:px-24 lg:max-w-screen-xl lg:px-8 lg:py-16 xl:py-28">
                <div class="flex flex-col items-center justify-between">
                    <div class="">
                        <div class="max-w-3xl">
                            <p class="text-center text-base text-gray-100">Sed ut perspiciatis unde omnis iste natus
                                error sit voluptatem accusantium doloremque it.</p>
                        </div>
                        <form method="POST" action="/admin/user/orders"
                              class="mx-auto mt-12 mb-2 max-w-xl sm:rounded-xl sm:border sm:border-gray-100 sm:bg-white sm:p-2 sm:shadow">
                            <div class="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
                                <div class="relative text-gray-500 sm:w-7/12">
                                    <label for="email" class="sr-only border-gray-300"></label>
                                    <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
                                        <svg class="h-5 w-5" xmlns="http://www.w3.org/2000/svg" fill="none"
                                             viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                                                  d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207"
                                                  class=""></path>
                                        </svg>
                                    </div>
                                    <input type="email" name="email" id="email" placeholder="Enter email address"
                                           class="w-full cursor-text rounded-xl border-2 py-4 pr-4 pl-10 text-base outline-none transition-all duration-200 ease-in-out sm:border-0 focus:border-transparent focus:ring"
                                           required="">
                                </div>
                                <button type="submit"
                                        class="group flex items-center justify-center rounded-xl bg-blue-700 px-6 py-4 text-white transition">
                                    <span class="group flex w-full items-center justify-center rounded text-center font-medium">Check Orders</span>
                                    <svg class="shrink-0 group-hover:ml-8 ml-4 h-4 w-4 transition-all"
                                         xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
                                         stroke="currentColor" stroke-width="2">
                                        <path stroke-linecap="round" stroke-linejoin="round"
                                              d="M14 5l7 7m0 0l-7 7m7-7H3"></path>
                                    </svg>
                                </button>
                            </div>
                        </form>
                        <div class="divide-gray-300/30 mt-12 flex flex-col items-center justify-center space-y-3 text-sm text-gray-700 sm:flex-row sm:items-start sm:space-y-0 sm:divide-x">
                            <div class="flex max-w-xs space-x-2 px-4">
                    <span class="shrink-0 flex h-14 w-14 items-center justify-center rounded-xl bg-white p-2.5 text-purple-500">
                      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                           stroke="currentColor" class="h-6 w-6">
                        <path stroke-linecap="round" stroke-linejoin="round"
                              d="M6.75 7.5l3 2.25-3 2.25m4.5 0h3m-9 8.25h13.5A2.25 2.25 0 0021 18V6a2.25 2.25 0 00-2.25-2.25H5.25A2.25 2.25 0 003 6v12a2.25 2.25 0 002.25 2.25z"></path>
                      </svg>
                    </span>
                                <p class="text-gray-100">Lorem ipsum dolor sit amet consectetur adipisicing elit.</p>
                            </div>
                            <div class="flex max-w-xs space-x-2 px-4">
                    <span class="shrink-0 flex h-14 w-14 items-center justify-center rounded-xl bg-white p-2.5 text-rose-500">
                      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                           stroke="currentColor" class="h-6 w-6">
                        <path stroke-linecap="round" stroke-linejoin="round"
                              d="M20.25 6.375c0 2.278-3.694 4.125-8.25 4.125S3.75 8.653 3.75 6.375m16.5 0c0-2.278-3.694-4.125-8.25-4.125S3.75 4.097 3.75 6.375m16.5 0v11.25c0 2.278-3.694 4.125-8.25 4.125s-8.25-1.847-8.25-4.125V6.375m16.5 0v3.75m-16.5-3.75v3.75m16.5 0v3.75C20.25 16.153 16.556 18 12 18s-8.25-1.847-8.25-4.125v-3.75m16.5 0c0 2.278-3.694 4.125-8.25 4.125s-8.25-1.847-8.25-4.125"></path>
                      </svg>
                    </span>
                                <p class="text-gray-100">Lorem ipsum dolor sit amet consectetur adipisicing elit.</p>
                            </div>
                        </div>
                    </div>
                    <div class="relative mt-20 hidden lg:block">
                        <svg xmlns="http://www.w3.org/2000/svg"
                             class="mx-auto my-6 h-10 w-10 animate-bounce rounded-full bg-blue-50 p-2 lg:hidden"
                             fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M16 17l-4 4m0 0l-4-4m4 4V3"></path>
                        </svg>
                        <div class="w-fit mx-auto flex overflow-hidden rounded-3xl bg-orange-400"
                             role="image-container"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
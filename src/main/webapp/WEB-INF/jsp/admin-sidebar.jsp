<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<aside class="fixed w-64 h-screen bg-gray-800 text-white flex flex-col">
    <div class="p-6">
        <h1 class="text-3xl font-bold">FashionKart</h1>
    </div>
    <ul class="flex flex-col mt-10">
        <li class="transition">
            <a href="/admin/dashboard" class="block py-2.5 px-4 rounded transition duration-200 hover:bg-gray-700 hover:text-white">
              <span class="flex items-center space-x-3">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path d="M13 19h6V9.978l-7-5.444-7 5.444V19h6v-6h2v6z"></path>
                </svg>
                <span>Dashboard</span>
              </span>
            </a>
        </li>
        <li class="transition">
            <a href="/admin/sales/info" class="block py-2.5 px-4 rounded transition duration-200 hover:bg-gray-700 hover:text-white">
              <span class="flex items-center space-x-3">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path d="M16 8v8m-4-5v5m-4-2v2m-2 4h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                </svg>
                <span>Analytics</span>
              </span>
            </a>
        </li>
        <li class="transition">
            <a href="#" class="block py-2.5 px-4 rounded transition duration-200 hover:bg-gray-700 hover:text-white">
              <span class="flex items-center space-x-3">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path>
                </svg>
                <span>Revenue</span>
              </span>
            </a>
        </li>
        <li class="transition">
            <a href="/admin/sellers/info" class="block py-2.5 px-4 rounded transition duration-200 hover:bg-gray-700 hover:text-white">
              <span class="flex items-center space-x-3">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path d="M18.364 5.636l-3.536 3.536m0 5.656l3.536 3.536M9.172 9.172L5.636 5.636m3.536 9.192l-3.536 3.536"></path>
                </svg>
                <span>Sellers</span>
              </span>
            </a>
        </li>
        <li class="transition">
            <a href="/controller/logout" class="block py-2.5 px-4 rounded transition duration-200 hover:bg-gray-700 hover:text-white">
              <span class="flex items-center space-x-3 text-gray-100">
                <svg fill="none" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg">
                    <path d="M17 16L21 12M21 12L17 8M21 12L7 12M13 16V17C13 18.6569 11.6569 20 10 20H6C4.34315 20 3 18.6569 3 17V7C3 5.34315 4.34315 4 6 4H10C11.6569 4 13 5.34315 13 7V8" stroke="#374151" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"></path>
                </svg>
                <span>Logout</span>
              </span>
            </a>
        </li>
    </ul>
</aside>
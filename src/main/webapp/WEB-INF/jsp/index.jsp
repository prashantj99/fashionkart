<%@ page import="com.fashionkart.entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User loggedInUser = session.getAttribute("user") == null ? null : ((User)(session.getAttribute("user")));

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Men T-Shirts - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:ital,wght@0,300;0,400;1,600&display=swap"
          rel="stylesheet"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lazysizes/5.3.0/lazysizes.min.js" async=""></script>
    <script src="/js/cart.js"></script>
    <style>
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .filter-section {
            min-width: 300px;
            transition: transform 0.3s ease-in-out;
        }

        .filter-heading {
            font-weight: bold;
            margin-bottom: 1rem;
        }

        .loading {
            text-align: center;
            padding: 1rem;
            font-size: 1.25rem;
        }

        .product-card:hover {
            transform: translateY(-5px);
            transition: transform 0.3s ease-in-out;
        }

        .swiper-slide img {
            object-fit: cover;
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body class="bg-gray-50 text-gray-800">

<%@include file="navbar.jsp"%>

<!-- Main Content -->
<div class="container mx-auto mt-8 px-6">
    <div class="flex justify-between w-full">

        <!-- Filters Section -->
        <div class="filter-section bg-gray-100 p-4 shadow-lg">
            <h2 class="filter-heading text-lg text-gray-800">Filters</h2>

            <!-- Gender Filter -->
            <div class="mb-6">
                <h3 class="text-md text-gray-700 mb-2">By Gender</h3>
                <div class="flex flex-col">
                    <label class="mb-2"><input type="radio" name="genderType" value="MEN" class="mr-2">Men's</label>
                    <label class="mb-2"><input type="radio" name="genderType" value="WOMEN" class="mr-2">Women's</label>
                    <label><input type="radio" name="genderType" value="KIDS" class="mr-2">Kid's</label>
                </div>
            </div>

            <!-- Categories Filter -->
            <div class="mb-6">
                <h3 class="text-md text-gray-700 mb-2">Categories</h3>
                <ul id="categoriesList">
                    <!-- Categories will be loaded here -->
                </ul>
            </div>

            <!-- Brand Filter -->
            <div class="mb-6">
                <h3 class="text-md text-gray-700 mb-2">Brand</h3>
                <ul id="brandList">
                    <!-- Brands will be loaded here -->
                </ul>
                <a href="#" class="text-blue-600 text-sm mt-2 inline-block hover:text-blue-800 transition-colors"
                   id="loadMoreBrands">+More</a>
            </div>

            <!-- Price Filter -->
            <div>
                <h3 class="text-md text-gray-700 mb-2">Price Range</h3>
                <div class="flex items-center space-x-3">
                    <input type="number" min="100" max="100000000" class="border border-gray-300 rounded px-2 py-1 w-1/3 text-gray-700" id="minPrice" placeholder="Min Price" value="100" />
                    <span class="text-gray-500">to</span>
                    <input type="number" min="100" max="100000000" class="border border-gray-300 rounded px-2 py-1 w-1/3 text-gray-700" id="maxPrice" placeholder="Max Price" value="100000000"/>
                </div>
            </div>

        </div>

        <!-- Product Listing Section -->
        <div class="product-listing w-full p-5">
            <div class="flex justify-between items-center mb-4 sticky h-94">
                <h2 class="text-xl font-semibold text-gray-800">Items <span id="totalItems">0</span>
                </h2>
                <div>
                    <label for="sort" class="mr-2 text-gray-700">Sort by:</label>
                    <select id="sort" class="border rounded-lg p-2 transition-colors">
                        <option value="priceLowToHigh" selected>Price: Low to High</option>
                        <option value="priceHighToLow">Price: High to Low</option>
                    </select>
                </div>
            </div>

            <!-- Products Grid -->
            <div id="productGrid" class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-2 lg:grid-cols-2 gap-6">
            <!-- Products will be loaded here -->
            </div>

            <!-- Loading Indicator -->
            <div id="loading" class="hidden flex items-center justify-center mt-5">
                <div class="spinner border-4 border-t-blue-500 border-t-4 border-gray-200 rounded-full w-10 h-10 animate-spin"></div>
            </div>
        </div>
    </div>
</div>

<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script>
    $(document).ready(function () {
        let productPageNumber = 1;
        let isLoading = false;
        let brandPageNumber = 1;
        let hasMoreProducts = true;
        let hasMoreBrands = true;

        const fetchBrands = function () {
            $.ajax({
                url: `http://localhost:8080/controller/brands?pageNumber=${brandPageNumber}`,
                method: 'GET',
                success: function ({brands, isLastPage}) {
                    const brandList = $('#brandList');
                    brands.forEach(function (brand) {
                        brandList.append(`<li><label><input type="checkbox" class="mr-2" name="brand" value="${brand.id}">${brand.name}</label></li>`);
                    });
                    hasMoreBrands = isLastPage;
                    brandPageNumber++;
                },
                error: function () {
                    console.error('Error fetching brands');
                }
            });
        };

        const fetchCategories = function () {
            $.ajax({
                url: 'http://localhost:8080/controller/categories',
                method: 'GET',
                success: function (categories) {
                    const categoriesList = $('#categoriesList');
                    categories.forEach(function (category) {
                        categoriesList.append(`<li><label><input type="checkbox" class="mr-2" name="category" value="${category.id}">${category.name}</label></li>`);
                    });
                },
                error: function () {
                    console.error('Error fetching categories');
                }
            });
        };

        const fetchProducts = function (resetPage = false) {
            if (resetPage) {
                productPageNumber = 1;
                $('#productGrid').empty();
            }

            if (isLoading || !hasMoreProducts) return;
            isLoading = true;
            $('#loading').removeClass('hidden');

            const sortBy = $('#sort').val();
            const minPrice = $('#priceRange').val();
            console.log(minPrice);
            const genderType = $('input[name="genderType"]:checked').val();

            const categories = $('input[name="category"]:checked').map(function () {
                return this.value;
            }).get();

            const brands = $('input[name="brand"]:checked').map(function () {
                return this.value;
            }).get();

            $.ajax({
                url: `http://localhost:8080/controller/search`,
                method: 'GET',
                data: {
                    pageNumber: productPageNumber,
                    sortBy: 'price',
                    sortingOrder: sortBy === 'priceLowToHigh' ? 'asc' : 'desc',
                    minPrice: $('#minPrice').val(),
                    maxPrice: $('#maxPrice').val(),
                    genderType: genderType,
                    categories: categories,
                    brands: brands,
                    search: $('#searchBar').val(),
                },
                success: function ({products, totalRecords, isLastPage}) {
                    console.log(products);
                    products.forEach(function (product) {
                        const productCard = pCard(product);
                        $('#productGrid').append(productCard);
                    });

                    $('#totalItems').text(totalRecords);
                    productPageNumber++;
                    hasMoreProducts = !isLastPage;
                    isLoading = false;
                    $('#loading').addClass('hidden');

                },
                error: function () {
                    $('#loading').addClass('hidden');
                    $('#productGrid').append('<p class="text-red-500">Failed to load products. Please try again.</p>');
                    console.error('Error fetching products');
                }
            });
        };

        const swiper = new Swiper('.swiper-container', {
            loop: true, // Enables continuous loop mode
            autoplay: {
                delay: 3000,
                disableOnInteraction: false,
            },
            pagination: {
                el: '.swiper-pagination',
                clickable: true,
            },
        });

        fetchBrands();
        fetchCategories();
        fetchProducts();

        let debounceTimer;

        const debounce = (func, delay) => {
            clearTimeout(debounceTimer);
            debounceTimer = setTimeout(func, delay);
        };

        $('#minPrice, #maxPrice, #searchBar, input[name="brand"], input[name="category"], input[name="genderType"]').on('change', function () {
            debounce(() => {
                productPageNumber = 1;
                hasMoreProducts = true;
                fetchProducts(true);
            }, 300);
        });

        $('#loadMoreBrands').on('click', function (e) {
            e.preventDefault();
            hasMoreBrands && fetchBrands();
            !hasMoreBrands && $('#loadMoreBrands').hide();
        });

        $(window).on('scroll', function () {
            if ($(window).scrollTop() + $(window).height() > $(document).height() - 100) {
                fetchProducts();
            }
        });

        const pCard = (product) => {
            const card = `<div class="relative m-10 w-full max-w-sm overflow-hidden rounded-lg bg-white shadow-lg transition-transform transform hover:scale-105">
                          <a href="/product/detail?productId=${product.id}">
                            <img class="w-full h-60 object-cover rounded-t-lg lazyload" src="${product.imagesUrls[0]}" alt="product image" />
                          </a>
                          <div class="p-5">
                            <a href="#">
                              <h5 class="text-xl font-semibold text-gray-900 truncate">${product.name}</h5>
                            </a>
                            <div class="mt-2.5 mb-4 flex items-center">
                              <span class="mr-2 rounded bg-yellow-200 px-2.5 py-0.5 text-xs font-semibold text-yellow-800">5.0</span>
                              ${[1, 2, 3, 4, 5].map((index) => `
                                <svg aria-hidden="true" class="h-5 w-5 text-yellow-300" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                  <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                                </svg>
                              `).join(' ')}
                            </div>
                            <div class="flex items-center justify-between mt-4">
                              <p class="text-2xl font-bold text-gray-900">&#x20B9;${product.price}</p>
                              <div class="flex space-x-2">
                                <button onclick="addToCart(${product.id})" class="bg-blue-600 flex items-center rounded-md px-3 py-2 text-white text-sm font-medium hover:bg-blue-700 focus:outline-none focus:ring-4 focus:ring-blue-300 transition-colors">
                                  <img width="20" height="20" src="https://img.icons8.com/ios-glyphs/30/shopping-cart--v1.png" alt="shopping-cart--v1" class="mr-1"/>
                                </button>
                                <button onclick="addToWishList(${product.id})" class="bg-red-600 flex items-center rounded-md px-3 py-2 text-white text-sm font-medium hover:bg-red-700 focus:outline-none focus:ring-4 focus:ring-red-300 transition-colors">
                                  <img width="20" height="20" src="https://img.icons8.com/external-tulpahn-flat-tulpahn/64/external-wishlist-online-shopping-tulpahn-flat-tulpahn.png" alt="wishlist" class="mr-1"/>
                                </button>
                              </div>
                            </div>
                          </div>
                        </div>`;
            return card;
        }
    });
</script>
</body>
</html>

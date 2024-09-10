<%@ page import="com.fashionkart.entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User loggedInUser = session.getAttribute("user") == null ? null : ((User) (session.getAttribute("user")));

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

<%@include file="navbar.jsp" %>

<!-- Main Content -->
<div class="flex mx-auto mt-8 px-6 w-full gap-2">
    <!-- Filters Section -->
    <div class="fixed bg-gray-100 p-4 shadow-lg w-64 mt-5" id="filters">
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
                <input type="number" min="100" max="100000000"
                       class="border border-gray-300 rounded px-2 py-1 w-1/3 text-gray-700" id="minPrice"
                       placeholder="Min Price" value="100"/>
                <span class="text-gray-500">to</span>
                <input type="number" min="100" max="100000000"
                       class="border border-gray-300 rounded px-2 py-1 w-1/3 text-gray-700" id="maxPrice"
                       placeholder="Max Price" value="100000000"/>
            </div>
        </div>

    </div>
    <div class="ml-64 p-2 w-full">
        <div class="product-listing w-full p-3">
            <div class="flex justify-between items-center mb-4 sticky h-94 gap-5">
                <!-- Search Bar -->
                <div class="flex justify-center mt-4 w-full">
                    <div class="relative w-full max-w-lg">
                        <input
                                id="searchQuery"
                                type="text"
                                class="w-full border border-gray-300 rounded-lg shadow-sm p-4 pr-12 focus:border-blue-500 focus:ring-blue-500"
                                placeholder="Search for products..."
                        />
                        <button
                                id="searchBtn"
                                class="absolute right-2 top-2 bg-blue-500 hover:bg-blue-600 text-white p-2 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <svg
                                    class="w-6 h-6"
                                    fill="none"
                                    stroke="currentColor"
                                    viewBox="0 0 24 24"
                                    xmlns="http://www.w3.org/2000/svg">
                                <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        stroke-width="2"
                                        d="M21 21l-4.35-4.35m0 0A7.5 7.5 0 1011 18.5a7.5 7.5 0 005.65-2.85z">
                                </path>
                            </svg>
                        </button>
                    </div>
                </div>

                <h2 class="text-xl font-semibold text-gray-800 w-full">
                    Found <span id="totalItems">0 Items</span>
                </h2>

                <div class="w-full">
                    <label for="sort" class="mr-2 text-gray-700">Sort by:</label>
                    <select id="sort" class="border rounded-lg p-2 transition-colors">
                        <option value="priceLowToHigh" selected>Price: Low to High</option>
                        <option value="priceHighToLow">Price: High to Low</option>
                    </select>
                </div>
            </div>

            <!-- Products Grid -->
            <div id="productGrid" class="grid grid-cols-4 sm:grid-cols-2 md:grid-cols-4 lg:grid-cols-4 gap-3">
                <!-- Products will be loaded here -->
            </div>
<%--            loader--%>
            <div id="loading" class="hidden flex items-center justify-center mt-5 h-96 text-blue-400">
                <svg class="w-8 h-8" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"
                     preserveAspectRatio="xMidYMid">
                    <g transform="translate(50,50)">
                        <g transform="scale(0.7)">
                            <circle cx="0" cy="0" r="50" fill="currentColor"></circle>
                            <circle cx="0" cy="-28" r="15" fill="white">
                                <animateTransform attributeName="transform" type="rotate" dur="1s"
                                                  repeatCount="indefinite"
                                                  keyTimes="0;1" values="0 0 0;360 0 0"></animateTransform>
                            </circle>
                        </g>
                    </g>
                </svg>
            </div>
        </div>
    </div>
    <!-- Product Listing Section -->
</div>

<script>
    $(document).ready(function () {
        let productPageNumber = 1;
        let isLoading = false;
        let brandPageNumber = 1;
        let hasMoreProducts = true;
        let hasMoreBrands = true;

        if(!hasMoreBrands){
            $('#loadMoreBrands').addClass('hidden');
        }
        $('input[name="category"]').on('change', function () {
            console.log('Checkbox changed:', $(this).val());
        });
        const fetchBrands = function () {
            $('#loadMoreBrands').addClass('hidden');
            $.ajax({
                url: `http://localhost:8080/controller/brands?pageNumber=${brandPageNumber}`,
                method: 'GET',
                success: function ({brands, isLastPage}) {
                    const brandList = $('#brandList');
                    brands.forEach(function (brand) {
                        brandList.append(`<li><label><input type="checkbox" class="mr-2" name="brand" value="${brand.id}">${brand.name}</label></li>`);
                    });
                    hasMoreBrands = !isLastPage;
                    brandPageNumber++;
                    if(hasMoreBrands){
                        $('#loadMoreBrands').removeClass('hidden');
                    }
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

            console.log("called!!")

            const sortBy = $('#sort').val();
            const minPrice = $('#priceRange').val();
            console.log(minPrice);
            const genderType = $('input[name="genderType"]:checked').val();

            const categories = $('input[name="category"]:checked').map(function () {
                return this.value;
            }).get();

            console.log(categories);

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
                    search: $('#searchQuery').val(),
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

        fetchBrands();
        fetchCategories();
        fetchProducts();

        let debounceTimer;

        const debounce = (func, delay) => {
            clearTimeout(debounceTimer);
            debounceTimer = setTimeout(func, delay);
        };

        $('#sort, #minPrice, #maxPrice, #searchQuery, input[name="brand"], input[name="category"], input[name="genderType"]').on('change', function () {
            debounce(() => {
                productPageNumber = 1;
                hasMoreProducts = true;
                fetchProducts(true);
            }, 300);
        });
        $('#filters').on('change', 'input[name="brand"], input[name="category"], input[name="genderType"]', function () {
            debounce(() => {
                console.log("Filter change detected");
                productPageNumber = 1;
                hasMoreProducts = true;
                fetchProducts(true);
            }, 1000);
        });
        $('#searchQuery').on('onkeydown', function () {
            debounce(() => {
                productPageNumber = 1;
                hasMoreProducts = true;
                fetchProducts(true);
            }, 300);
        });
        $('#searchBtn').on('click', function () {
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
            const cardTemplate =
                `<div class="flex flex-col justify-between w-[300px] bg-white min-h-80">
                    <div class="relative">
                      <a href="/product/detail?productId=${product.id}">
                            <img src="${product.imagesUrls[0]}" alt="${product.name}" class="w-full h-70 object-cover hover:object-scale-down">
                      </a>
                      ${
                        product.discountPercentage ?
                        `<div class="absolute top-2 right-2 bg-indigo-500 text-white text-xs font-bold px-2 py-1 rounded-lg">
                            ${product.discountPercentage}% Off
                         </div>`
                        : ""
                      }
                    </div>

                    <!-- Product Info -->
                    <div class="mt-4 p-2">
                      <a href="/product/detail?productId=${product.id} class="text-lg font-bold text-gray-900">${product.name}</a>
                      <p class="text-gray-500 text-sm">${product.description}</p>
                    </div>

                    <!-- Pricing -->
                    <div class="p-2 flex items-center justify-between mt-1">
                      <div class="flex items-center space-x-2">
                        <span class="text-xl font-bold text-green-700">&#x20B9; ${product.price*(1-product.discountPercentage*0.01)}</span>
                        <span class="text-red-400 line-through">&#x20B9; ${product.price}</span>
                      </div>
                      <div>
                          ${
                            product.discountPercentage ?
                            ` <span class="text-indigo-500 text-sm font-bold">${product.discountPercentage}% Off</span>`
                            : ""
                          }
                       </div>
                    </div>
                    <div class="p-2 flex gap-2 w-full">
                        <button onclick="addToWishList(${product.id})" class="w-full h-12 text-gray-900 border border-gray-300 flex items-center justify-center gap-2 hover:bg-gray-200">
                            <img class="text-red" width="24" height="24" src="https://img.icons8.com/sf-black-filled/64/shopping-bag.png" alt="shopping-bag"/>
                            <span>Wishlist</span>
                        </button>
                        <button onclick="addToCart(${product.id})" class="w-full h-12 text-gray-900 border border-gray-300 flex items-center justify-center gap-2 hover:bg-gray-200">
                            <img width="24" height="24" src="https://img.icons8.com/ios-glyphs/50/shopping-cart.png" alt="shopping-cart"/>
                            <span>Cart</span>
                        </button>
                    </div>
                  </div>`;
            return cardTemplate;
        }
    });
</script>

</body>
</html>

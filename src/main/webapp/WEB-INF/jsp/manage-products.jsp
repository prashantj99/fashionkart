<%@ page import="com.fashionkart.entities.Seller" %>
<%@ page import="com.fashionkart.service.SellerService" %>
<%@ page import="com.fashionkart.serviceimpl.SellerServiceImpl" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="bg-gray-100">
<%
    Seller seller = (Seller)session.getAttribute("seller");
%>
<section class="py-16">
    <div class="container mx-auto max-w-full bg-white p-8 rounded-lg shadow-lg">
        <h2 class="text-3xl font-bold mb-6 text-primary">Manage Products</h2>

        <table class="min-w-full divide-y divide-gray-200">
            <thead>
            <tr>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Price</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Quantity Available</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
            </tr>
            </thead>
            <tbody id="product-list" class="bg-white divide-y divide-gray-200">
            <!-- Existing products will be rendered here initially -->
            </tbody>
        </table>

        <div class="mt-4">
            <button id="loadMore" class="btn-primary px-4 py-2 rounded-lg">Load More</button>
        </div>
    </div>
</section>

<!-- Edit Product Modal -->
<div id="editProductModal" class="fixed inset-0 bg-gray-500 bg-opacity-75 flex justify-center items-center hidden">
    <div class="bg-white p-6 rounded-lg shadow-lg w-96">
        <h3 class="text-xl font-bold mb-4">Edit Product</h3>
        <form id="editProductForm">
            <input type="hidden" id="editProductId" name="productId">
            <div class="mb-4">
                <label for="editName" class="block text-secondary text-lg font-medium mb-1">Name</label>
                <input type="text" id="editName" name="name" class="w-full px-4 py-2 border border-primary rounded-lg" required>
            </div>
            <div class="mb-4">
                <label for="editPrice" class="block text-secondary text-lg font-medium mb-1">Price</label>
                <input type="number" id="editPrice" name="price" class="w-full px-4 py-2 border border-primary rounded-lg" step="0.01" required>
            </div>
            <div class="mb-4">
                <label for="editQuantity" class="block text-secondary text-lg font-medium mb-1">Quantity Available</label>
                <input type="number" id="editQuantity" name="quantityAvailable" class="w-full px-4 py-2 border border-primary rounded-lg" required>
            </div>
            <div class="flex justify-end">
                <button type="button" id="saveEdit" class="btn-primary px-4 py-2 rounded-lg mr-2">Save</button>
                <button type="button" id="cancelEdit" class="btn-secondary px-4 py-2 rounded-lg">Cancel</button>
            </div>
        </form>
    </div>
</div>

<script>
    let currentPage = 1;
    let hasMore = true;
    let loading = false;
    const fetchProducts = () => {
        loading = true;
        $('#loadMore').addClass('hidden');
        $.ajax({
            url: `/controller/products?sellerId=<%=seller.getId()%>&pageNumber=${currentPage}`,
            method: 'GET',
            dataType: 'json',
            success: function ({products, isLastPage}) {
                if (products && products.length > 0) {
                    updateProductList(products);
                    hasMore = !isLastPage;
                    currentPage++;
                }
                loading = false;
                !isLastPage && $('#loadMore').removeClass('hidden');
            },
            error: function (xhr, status, error) {
                console.error('Error loading more products:', error);
                loading = false;
                $('#loadMore').removeClass('hidden');
            }
        });
    }

    $('#loadMore').on('click', function () {
        !loading && hasMore && fetchProducts();
    });

    fetchProducts();

    function updateProductList(products) {
        const $productList = $('#product-list');

        products.forEach(product => {
            const rowClass = product.quantityAvailable <= 0 ? 'bg-red-100' : '';
            const productRow = `
                <tr class="${rowClass}">
                    <td class="px-6 py-4 whitespace-nowrap">${product.name}</td>
                    <td class="px-6 py-4 whitespace-nowrap">$${product.price}</td>
                    <td class="px-6 py-4 whitespace-nowrap">${product.quantityAvailable}</td>
                    <td class="px-6 py-4 whitespace-nowrap">
                        <button onclick="showEditForm(${product.id}, '${product.name}', ${product.price}, ${product.quantityAvailable})" class="text-blue-500">Edit</button>
                        <button onclick="deleteProduct(${product.id})" class="text-red-500">Delete</button>
                    </td>
                </tr>
            `;
            $productList.append(productRow);
        });
    }

    window.showEditForm = function (id, name, price, quantity) {
        $('#editProductId').val(id);
        $('#editName').val(name);
        $('#editPrice').val(price);
        $('#editQuantity').val(quantity);
        $('#editProductModal').removeClass('hidden');
    };

    $('#cancelEdit').on('click', function () {
        $('#editProductModal').addClass('hidden');
    });

    $('#saveEdit').on('click', function () {
        const formData = {
            productId: $('#editProductId').val(),
            name: $('#editName').val(),
            price: $('#editPrice').val(),
            quantityAvailable: $('#editQuantity').val(),
            action:'edit',
        };

        $.ajax({
            url: '/controller/product/operation',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            success: function (data) {
                if (data.success) {
                    alert('Product updated successfully');
                    $('#editProductModal').addClass('hidden');
                    $('#product-list').empty();
                    $('#loadMore').show().click();

                    currentPage = 1; //reset page
                    hasMore = true;

                    fetchProducts(); //re - fetch after update

                } else {
                    alert('Failed to update product');
                }
            },
            error: function (xhr, status, error) {
                console.error('Error editing product:', error);
            }
        });
    });

    window.deleteProduct = function (productId) {
        if (confirm('Are you sure you want to delete this product?')) {
            $.ajax({
                url: `/controller/product/operation`,
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({productId, action: 'delete'}),
                success: function (data) {
                    if (data.success) {
                        alert('Product deleted successfully');
                        $('#product-list').empty();
                        currentPage = 1;
                        hasMore = true;
                        $('#loadMore').show().click();
                        fetchProducts();
                    } else {
                        alert('Failed to delete product');
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error deleting product:', error);
                }
            });
        }
    };
</script>

</body>
</html>

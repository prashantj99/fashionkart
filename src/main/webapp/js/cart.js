// Function to update cart quantity
function updateCart(cartItemId, change = 0) {
    let currentQuantity = parseInt($(`#cart-item-${cartItemId}-quantity`).val());
    let newQuantity = Math.max(0, currentQuantity + change);
    let selectedSize = $(`#product-${cartItemId}-size`).val();

    console.log({
        cartItemId,
        requiredQuantity: newQuantity,
        selectedSize,
    })
    if (newQuantity < 1 && confirm("Do you want to remove the item from the cart?")) {
        removeFromCart(cartItemId);
        return;
    }
    $.ajax({
        url: '/cart/operation/update',
        method: 'POST',
        data: {
            cartItemId,
            requiredQuantity: newQuantity,
            selectedSize,
        },
        success: function (data) {
            alert(data)
            location.reload();
        },
        error: function (xhr) {
            alert(`Error: ${xhr.responseText}`);
        }
    });
}

// Function to remove item from cart
function removeFromCart(cartItemId) {
    $.ajax({
        url: '/cart/operation/update',
        method: 'POST',
        data: {
            cartItemId: cartItemId,
            requiredQuantity: 0,
            selectedSize: $(`#product-${cartItemId}-size`).val()
        },
        success: function () {
            location.reload();
        },
        error: function (xhr) {
            alert(`Error: ${xhr.responseText}`);
        }
    });
}

function addToWishList(productId){
    console.log(productId);
    $.ajax({
        url: '/controller/wishlist/add',
        type: 'POST',
        data: {
            productId: productId,
        },
        success: function (response) {
            alert('Product added to wishlist');
        },
        error: function () {
            alert('Error adding product to wishlist');
        }
    });
}

function addToCart(productId, size="M"){
    console.log(productId);
    console.log(size);
    $.ajax({
        url: '/cart/operation/add',
        type: 'POST',
        data: {
            productId: productId,
            selectedSize: size,
        },
        success: function (response) {
            alert('Product added to cart');
        },
        error: function (xhr, status, error) {
            alert('Error adding product to cart: ' + xhr.responseText);
        }
    });
}

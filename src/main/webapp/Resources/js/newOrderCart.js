//Quang Qui

// Lấy button xem giỏ hàng
const viewCartBtn = document.querySelector("#view-cart-btn");

// Thêm event listener click cho button xem giỏ hàng
viewCartBtn.addEventListener("click", toggleCart);

// Lấy phần tử giỏ hàng
const cart = document.querySelector("#cart");

// Lấy phần tử danh sách sản phẩm trong giỏ hàng
const cartItems = document.querySelector("#cart-items");

// Lấy phần tử hiển thị tổng giá trị trong giỏ hàng
const cartTotalAmount = document.querySelector("#cart-total-amount");

// Khởi tạo mảng sản phẩm trong giỏ hàng
let cartItemsArray = [];

// Load dữ liệu từ cookies
loadCartFromCookies();

// Định nghĩa hàm loadCartFromCookies
function loadCartFromCookies() {
    // Lấy giá trị của cookie với tên 'cartItems'
    const cartItemsCookie = document.cookie.replace(/(?:(?:^|.*;\s*)cartItems\s*\=\s*([^;]*).*$)|^.*$/, "$1");
    if (cartItemsCookie) {
        // Nếu cookie tồn tại, chuyển đổi giá trị của cookie thành mảng sản phẩm trong giỏ hàng
        cartItemsArray = JSON.parse(cartItemsCookie);
    }

    // Cập nhật thông tin badge giỏ hàng
    updateCartBadge();

    // Cập nhật danh sách sản phẩm trong giỏ hàng
    updateCartItems();
}

// Định nghĩa hàm saveCartToCookies
function saveCartToCookies() {
    // Chuyển đổi mảng sản phẩm trong giỏ hàng thành giá trị cookie
    const cartItemsCookie = JSON.stringify(cartItemsArray);

    // Lưu giá trị cookie với tên 'cartItems'
    document.cookie = "cartItems=" + cartItemsCookie + ";path=/";
}

// Định nghĩa hàm toggleCart
function toggleCart() {
    // Toggle thuộc tính hiển thị của phần tử giỏ hàng
    cart.style.display = cart.style.display === "none" ? "block" : "none";
}

// Định nghĩa hàm updateCartBadge
function updateCartBadge() {
    // Lấy phần tử badge của giỏ hàng
    const cartBadge = document.querySelector("#cart-badge");

    // Lấy tổng số lượng các sản phẩm trong mảng cartItemsArray
    const totalQuantity = cartItemsArray.reduce((total, item) => total + item.quantity, 0);

    // Đặt nội dung text của phần tử badge của giỏ hàng thành tổng số lượng sản phẩm
    cartBadge.textContent = totalQuantity;
}

// Định nghĩa hàm updateCartItems
function updateCartItems() {
    // Xóa các phần tử sản phẩm trong giỏ hàng
    cartItems.innerHTML = "";

    // Khởi tạo biến giá tổng
    let totalPrice = 0;

    // Lặp qua mảng các sản phẩm trong giỏ hàng
    cartItemsArray.forEach((item) => {
        // Tạo một phần tử danh sách
        const listItem = document.createElement("li");

        // Tạo một phần tử div để chứa tên sản phẩm và số lượng
        const div = document.createElement("div");
        div.textContent = item.productId + " " + item.productName + " " + "x" + " ";

        // Tạo một phần tử nút để giảm số lượng sản phẩm
        const decreaseBtn = document.createElement("button");
        decreaseBtn.textContent = "-";
        decreaseBtn.addEventListener("click", () => {
            if (item.quantity > 1) {
                item.quantity--;
                updateCartItems();
                saveCartToCookies();
            } else {
                const index = cartItemsArray.findIndex((cartItem) => cartItem.productId === item.productId);
                cartItemsArray.splice(index, 1);
                saveCartToCookies();
                updateCartBadge();
                updateCartItems();
            }
        });
        div.appendChild(decreaseBtn);

        // Tạo một phần tử span để hiển thị số lượng sản phẩm
        const quantitySpan = document.createElement("span");
        quantitySpan.textContent = " " + item.quantity;
        div.appendChild(quantitySpan);

        // Tạo một phần tử nút để tăng số lượng sản phẩm
        const increaseBtn = document.createElement("button");
        increaseBtn.textContent = "+";
        increaseBtn.addEventListener("click", () => {
            event.preventDefault();
            alert("Vui lòng trở về home nếu muốn tăng số lượng sản phẩm!");
        });
        div.appendChild(increaseBtn);

        listItem.appendChild(div);

        // Tính toán giá tổng của sản phẩm
        const totalProductPrice = item.price * item.quantity;
        totalPrice += totalProductPrice;

        // Tạo một phần tử span để hiển thị giá tổng của sản phẩm
        const totalProductPriceSpan = document.createElement("span");
        totalProductPriceSpan.textContent = "" + totalProductPrice.toLocaleString("vi-VN") + " đ";
        listItem.appendChild(totalProductPriceSpan);

        // Tạo một phần tử nút để xóa sản phẩm khỏi giỏ hàng
        const removeBtn = document.createElement("button");
        removeBtn.textContent = "Remove";
        removeBtn.addEventListener("click", () => {
            const index = cartItemsArray.findIndex((cartItem) => cartItem.productId === item.productId);
            cartItemsArray.splice(index, 1);
            saveCartToCookies();
            updateCartBadge();
            updateCartItems();
        });
        listItem.appendChild(removeBtn);

        // Thêm phần tử danh sách vào giỏ hàng
        cartItems.appendChild(listItem);
    });

    // Đặt nội dung text của phần tử giá tổng của giỏ hàng thành giá tổng
    cartTotalAmount.textContent = "" + totalPrice.toLocaleString("vi-VN") + " đ";
}


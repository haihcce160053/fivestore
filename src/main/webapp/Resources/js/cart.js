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

// Lấy button thanh toán
const checkoutBtn = document.querySelector("#checkout-button");


// Khởi tạo mảng sản phẩm trong giỏ hàng
let cartItemsArray = [];

// Load dữ liệu từ cookies
loadCartFromCookies();

// Định nghĩa hàm loadCartFromCookies
function loadCartFromCookies() {
    // Lấy giá trị của cookie với tên 'cartItems'
    const cartItemsCookie = document.cookie.replace(/(?:(?:^|.*;\s*)cartItems\s*\=\s*([^;]*).*$)|^.*$/, "$1");
//const cartItemsCookie: Khai báo một hằng số có tên là "cartItemsCookie" để lưu trữ giá trị của cookie.
//document.cookie: Trả về tất cả các cookie được liên kết với trang web hiện tại. Mỗi cookie được trả về dưới dạng một chuỗi có định dạng "tên=giá trị".
//replace: Phương thức replace() được sử dụng để tìm kiếm và thay thế một chuỗi hoặc biểu thức chính quy trong chuỗi.
///(?:(?:^|.*;\s*)cartItems\s*\=\s*([^;]*).*$)|^.*$/, "$1": Đây là biểu thức chính quy được sử dụng để tìm kiếm giá trị của cookie có tên là "cartItems". Biểu thức chính quy này thực hiện các thao tác sau:
//(?:(?:^|.*;\s*)cartItems\s*\=\s*([^;]*).*$): Tìm kiếm cookie có tên là "cartItems" và lấy giá trị của nó.
//(?:^|.*;\s*): Tìm kiếm bắt đầu cookie hoặc dấu chấm phẩy trước đó, đảm bảo rằng nó không phải là một phần của tên cookie khác.
//cartItems: Tìm kiếm tên của cookie là "cartItems".
//\s*\=\s*: Tìm kiếm dấu bằng và loại bỏ khoảng trắng trước và sau nó.
//([^;]*): Lấy giá trị của cookie, đảm bảo rằng nó không bao gồm dấu chấm phẩy cuối cùng.
//.*$: Loại bỏ mọi ký tự còn lại sau giá trị cookie.
//|^.*$: Nếu cookie không được tìm thấy, lấy giá trị mặc định là chuỗi rỗng.
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

// Thêm event listener click cho button thanh toán
checkoutBtn.addEventListener("click", checkout);

// Định nghĩa hàm toggleCart
function toggleCart() {
    // Toggle thuộc tính hiển thị của phần tử giỏ hàng
    cart.style.display = cart.style.display === "none" ? "block" : "none";
}

document.addEventListener('DOMContentLoaded', function () {
    // Lặp qua tất cả các nút "Add to Cart" và gán sự kiện click cho từng nút
    var addToCartButtons = document.querySelectorAll('button[id^="cart-"]');
    for (var i = 0; i < addToCartButtons.length; i++) {
        addToCartButtons[i].addEventListener('click', function () {
            // Lấy thông tin của sản phẩm từ id của nút "Add to Cart"
            var productId = this.id.split('-')[1];
            var productName = document.getElementById("title-" + productId).value;
            var price = document.getElementById("price-" + productId).innerHTML.replace("<b>Price: </b>", "").replace("đ", "").replaceAll(".", "");
            var numberStock = document.getElementById("quantity-" + productId).innerHTML.replace("<b>Quantity: </b>", "");
            // Gọi hàm addToCart với các tham số tương ứng
            addToCart(productId, productName, price, numberStock);
        });
    }
});

// Định nghĩa hàm addToCart
function addToCart(productId, productName, price, numberStock) {
    // Tìm sản phẩm trong mảng sản phẩm trong giỏ hàng có cùng id với sản phẩm đã thêm vào
    const cartItem = cartItemsArray.find((item) => item.productId === productId);
    if (cartItem && (cartItem.quantity < numberStock)) {
        // Nếu sản phẩm đã tồn tại trong giỏ hàng, tăng số lượng của nó lên 1
        cartItem.quantity++;
    } else if (!cartItem) {
        // Nếu sản phẩm chưa tồn tại trong giỏ hàng, thêm sản phẩm vào mảng sản phẩm trong giỏ hàng
        cartItemsArray.push({productId, productName, price, quantity: 1});
    } else {
        event.preventDefault();
        alert("Không đủ số lượng trong kho");
    }
    // Lưu mảng sản phẩm trong giỏ hàng vào cookies
    saveCartToCookies();


    // Cập nhật thông tin badge giỏ hàng
    updateCartBadge();

    // Cập nhật danh sách sản phẩm trong giỏ hàng
    updateCartItems();
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
            var numberStock = document.getElementById("quantity-" + item.productId).innerHTML.replace("<b>Quantity: </b>", "");
            if (item.quantity < numberStock) {
                item.quantity++;
                saveCartToCookies();
                updateCartItems();
            } else {
                event.preventDefault();
                alert("Không đủ số lượng trong kho");
            }
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


// Define the checkout function
function checkout() {
    // Display an alert with the total price
    const totalPrice = cartTotalAmount.textContent;
    console.log(totalPrice);
    if (totalPrice === "0 đ") {
        // Hiển thị thông báo
        const confirmMessage = "Bạn chưa có món hàng nào!";
        event.preventDefault();
        confirm(confirmMessage);
    } else {
        // Hiển thị thông báo về tổng giá trị và yêu cầu người dùng xác nhận
        const confirmMessage = "Bạn có chắc chắn muốn đặt hàng với tổng giá trị là: " + totalPrice + "?";
        event.preventDefault();
        const shouldCheckout = confirm(confirmMessage);
        if (shouldCheckout) {
            // Gửi biểu mẫu lên servlet
            document.getElementById("checkout-form").submit();
        }
    }
}




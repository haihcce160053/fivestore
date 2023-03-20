//---------- Xử lý lấy số tiền trong giỏ hàng vào ô input---------------------------------------------------------

// Lấy thẻ span trong div chứa tổng tiền
var cartTotalSpan = document.getElementById("cart-total-amount");

// Lấy thẻ input
var totalBillInput = document.getElementById("txtTotalBill");

// 
var linkQRCode = document.getElementById("linkQR");
var linkQRCodeOrgirin = linkQRCode.value;

// Thiết lập giá trị ban đầu cho thẻ input
var totalBill = cartTotalSpan.innerText;
totalBill = totalBill.replaceAll(".", "").replace(" đ", "");
totalBillInput.value = totalBill;

linkQRCode.value += totalBill;


// Lắng nghe sự kiện thay đổi trên thẻ span
cartTotalSpan.addEventListener('DOMSubtreeModified', function () {
    // Cập nhật giá trị của thẻ input tại đây
    var he = cartTotalSpan.innerText;
    he = he.replaceAll(".", "").replace(" đ", "");
    if (he === '0') {
        window.location.href = 'http://localhost:8080/';
    } else {
        totalBillInput.value = he;
        linkQRCode.value = "";
        linkQRCode.value = linkQRCodeOrgirin;
        linkQRCode.value += he;
        linkQRCode.value += "&addInfo=Payment%20OrderID%20";
        //Sau khi ghép thành công số tiền cần chuyển thì tiếp tục nối chuỗi gồm mã đơn hàng 
        var orderID = document.getElementById("txtOrderID");
        linkQRCode.value += orderID.value + "%20";
        //Sau khi ghép thành công mã đơn hàng thì tiếp tục nối chuỗi username
        var username = document.getElementById("txtUsername");
        linkQRCode.value += username.value;
        //Sau khi ghép thành công username thì set src cho the img
        var imgQR = document.getElementById("txtQRCode");
        imgQR.setAttribute('src', linkQRCode.value);
    }
});

linkQRCode.value += "&addInfo=Payment%20OrderID%20";
//Sau khi ghép thành công số tiền cần chuyển thì tiếp tục nối chuỗi gồm mã đơn hàng 
var orderID = document.getElementById("txtOrderID");
linkQRCode.value += orderID.value + "%20";
//Sau khi ghép thành công mã đơn hàng thì tiếp tục nối chuỗi username
var username = document.getElementById("txtUsername");
linkQRCode.value += username.value;
//Sau khi ghép thành công username thì set src cho the img
var imgQR = document.getElementById("txtQRCode");
imgQR.setAttribute('src', linkQRCode.value);

//-------------------------------------------------------------------------------------------------------------------
const paymentMethodSelect = document.getElementById("paymentMethod");
//-------------------------------------------------------------------------------------------------------------------
//Khi bấm vào nút submit order thì sẽ xử lý giỏ hàng thành chuỗi gửi lên servlet

const form = document.getElementById("newOrderForm");
const btnOrder = document.getElementById("btnSubmit");
const fullNameInput = document.getElementById("txtFullname");
const detailAddressInput = document.getElementById("txtDetailAddress");
const provinceSelect = document.getElementById("ls_province");
const districtSelect = document.getElementById("ls_district");
const wardSelect = document.getElementById("ls_ward");
const errorElement = document.getElementById("regError");

function yourFunction(event) {
    event.preventDefault();

    //VALIDATION FORM
    let messages = [];

    // validate Full Name field
    if (fullNameInput.value === "") {
        messages.push("Full Name is required");
    }

    // validate Detail Address field
    if (detailAddressInput.value === "") {
        messages.push("Detail Address is required");
    }

    // validate Province select
    if (provinceSelect.value === "") {
        messages.push("Province is required");
    }

    // validate District select
    if (districtSelect.value === "") {
        messages.push("District is required");
    }

    // validate Ward select
    if (wardSelect.value === "") {
        messages.push("Ward is required");
    }

    // validate Payment Method select
    if (paymentMethodSelect.value === "") {
        messages.push("Payment Method is required");
    }

    // display error messages
    if (messages.length > 0) {
        event.preventDefault();
        errorElement.innerText = messages.join(", ");
    } else {
        // Process Cart to String
        //Ô input ẩn trong form có id là blind
        const inputElement = document.getElementById("blind");
        const ulElement = document.getElementById('cart-items');
        const liElements = ulElement.querySelectorAll('li');

        let items = "";
        for (let i = 0; i < liElements.length; i++) {
            const divElement = liElements[i].querySelector('div');
            const spanElements = liElements[i].querySelectorAll('span');
            const itemString = divElement.textContent.trim() + ":" + spanElements[1].textContent.trim();
            items += itemString + "/";
        }
        // Loại bỏ các ký tự đặc biệt khỏi chuỗi bằng phương thức replace()
        items = items.replaceAll("- ", "<<").replaceAll("+", ">>").replaceAll("Remove", "").replaceAll(".", "").replaceAll("x", "").replaceAll("đ", "").replaceAll("   ", "");
        //Chuỗi sau khi xử lý sẽ gán vào ô input ẩn để tiện trên Servlet lấy data
        inputElement.value = items;
        
        btnOrder.removeEventListener("click", yourFunction);
        btnOrder.click();
    }
}

btnOrder.addEventListener("click", yourFunction);



//SHOW POP-UP QR CODE-------------------------------------------------------------------------------------------------------------------
const checkbox = document.getElementById('confirm-checkbox');
const closeBtn = document.querySelector('.popup-close');
const backdrop = document.querySelector('.popup-backdrop');
var popup = document.getElementById("vietqr-popup");
// Lắng nghe sự kiện onchange của thẻ <select>
paymentMethodSelect.addEventListener("change", function () {
    // Lấy giá trị được chọn
    var selectedValue = paymentMethodSelect.value;

    // Nếu giá trị được chọn là "VietQR"
    if (selectedValue === "VietQR") {
        // Hiển thị pop-up
        popup.style.display = "block";
        backdrop.classList.add('show');
    } else {
        // Ẩn pop-up nếu không chọn "VietQR"
        popup.style.display = "none";
        backdrop.sclassList.remove('show');
    }
});

// Lắng nghe sự kiện onchange của thẻ <select>
paymentMethodSelect.addEventListener("click", function () {
    // Lấy giá trị được chọn
    var selectedValue = paymentMethodSelect.value;

    // Nếu giá trị được chọn là "VietQR"
    if (selectedValue === "VietQR") {
        // Hiển thị pop-up
        popup.style.display = "block";
        backdrop.classList.add('show');
    } else {
        // Ẩn pop-up nếu không chọn "VietQR"
        popup.style.display = "none";
        backdrop.sclassList.remove('show');
    }
});

closeBtn.addEventListener('click', function () {
    popup.style.display = "none";
    backdrop.classList.remove('show');
});

backdrop.addEventListener('click', function () {
    popup.style.display = "none";
    backdrop.classList.remove('show');
});

checkbox.addEventListener('change', (event) => {
    if (event.target.checked) {
        const viewCartBtn = document.querySelector("#view-cart-btn");
        viewCartBtn.removeEventListener("click", toggleCart);

        const navbarBrand = document.querySelector(".navbar-brand");
        navbarBrand.addEventListener("click", function (event) {
            event.preventDefault();
            alert("Vui lòng không chuyển sang trang khác nếu đã chuyển khoản cho đơn hàng này!");
        });

        const viewPurchaseBtn = document.getElementById("view-purchase-btn");
        viewPurchaseBtn.removeAttribute("onclick");
        viewPurchaseBtn.addEventListener("click", function (event) {
            event.preventDefault();
            alert("Vui lòng không chuyển sang trang khác nếu đã chuyển khoản cho đơn hàng này!");
        });

        const profileBtn = document.getElementById("view-profile-btn");
        profileBtn.removeAttribute("onclick");
        profileBtn.addEventListener("click", function (event) {
            event.preventDefault();
            alert("Vui lòng không chuyển sang trang khác nếu đã chuyển khoản cho đơn hàng này!");
        });
        const links = document.querySelectorAll("a");

        links.forEach(link => {
            link.addEventListener("click", function (event) {
                event.preventDefault(); // ngăn chặn hành vi mặc định của thẻ <a>
                alert("Vui lòng không chuyển sang trang khác nếu đã chuyển khoản cho đơn hàng này!");
            });
        });

        // Chặn việc tải lại trang và nhập URL mới bằng sự kiện beforeunload
        window.addEventListener("beforeunload", function (event) {
            event.preventDefault();
            event.returnValue = "";
        });

    }
});

        
/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/ClientSide/javascript.js to edit this template
 */

function showConfirmBox() {
    const overlay = document.getElementById("overlay1");
    const confirmBox = document.getElementById("confirm-box1");
    overlay.style.display = "block";
    confirmBox.style.display = "block";
}

function hideConfirmBox() {
    const overlay = document.getElementById("overlay1");
    const confirmBox = document.getElementById("confirm-box1");
    overlay.style.display = "none";
    confirmBox.style.display = "none";
}

function validateForm() {
    const pictureLink = document.getElementById("pictureLink").value;
    const productID = document.getElementById("productID").value;
    const productName = document.getElementById("productName").value;
    const description = document.getElementById("description").value;
    const type = document.getElementById("type").value;
    const quantity = document.getElementById("quantity").value;
    const price = document.getElementById("price").value;
    const exp = document.getElementById("exp").value;
    const origin = document.getElementById("origin").value;
    const soldAmount = document.getElementById("soldAmount").value;

    const regError = document.getElementById("regError");
    regError.innerHTML = "";

    if (pictureLink === "" || productID === "" || productName === "" || description === "" || type === "" || quantity === "" || price === "" || exp === "" || origin === "" || soldAmount === "") {
        regError.innerHTML = "Please fill in all fields.";
        return false;
    } else if (productID.length > 10) {
        regError.innerHTML = "Product ID cannot be more than 10 characters long.";
        return false;
    } else if (!pictureLink.match(/\.(jpeg|jpg|gif|png)$/) || !/^http/.test(pictureLink)) {
        regError.innerHTML = "Picture link must be a valid URL and have a file extension of jpeg, jpg, gif, or png.";
        return false;
    } else if (productName.length > 50) {
        regError.innerHTML = "Product name cannot be more than 50 characters long.";
        return false;
    } else if (isNaN(quantity) || isNaN(price) || isNaN(soldAmount)) {
        regError.innerHTML = "Quantity, price, and sold amount must be numbers.";
        return false;
    } else {
        return true;
    }
}

const form = document.querySelector("form");
form.addEventListener("submit", function (event) {
    event.preventDefault();
    if (validateForm()) {
        showConfirmBox();
        const overlay = document.getElementById("overlay1");
        const noButton = document.getElementById("no-button1");
        overlay.addEventListener("click", hideConfirmBox);
        noButton.addEventListener("click", hideConfirmBox);
        const yesButton = document.getElementById("yes-button1");
        yesButton.addEventListener("click", function () {
            form.submit();
        });
    }
}
);

const confirmBox = document.getElementById("confirm-box");
const overlay = document.getElementById("overlay");
const yesButton = document.getElementById("yes-button");
const noButton = document.getElementById("no-button");
const submitButton = document.getElementById("submit-button");
//-------------------------------------------------------------------
const confirmBox1 = document.getElementById("confirm-box1");
const overlay1 = document.getElementById("overlay1");
const yesButton1 = document.getElementById("yes-button1");
const noButton1 = document.getElementById("no-button1");
//-------------------------------------------------------------------
const confirmBox2 = document.getElementById("confirm-box2");
const overlay2 = document.getElementById("overlay2");
const yesButton2 = document.getElementById("yes-button2");
const noButton2 = document.getElementById("no-button2");
//-------------------------------------------------------------------
// Lấy các thẻ input và nút chỉnh sửa từ form 1
const form1 = document.getElementById('form-1');
const form1Inputs = document.querySelectorAll('#form-1 .editable');
const form1editButton = document.getElementById('edit-button');
const form1submitButton = document.getElementById('submit-button');

// Lấy các thẻ input và nút chỉnh sửa từ form 2
const form = document.querySelector('#form-2');
const form2Inputs = document.querySelectorAll('#form-2 .editable');
const form2editButton = document.getElementById('edit-pass-button');
const form2submitButton = document.getElementById('submit-pass-button');
const currentPasswordInput = form.querySelector('#input-oldpassword');
const newPasswordInput = form.querySelector('#input-newpassword');
const confirmPasswordInput = form.querySelector('#input-confirmpassword');

//Span ERROR
const mySpan = document.getElementById('regError1');
const mySpan1 = document.getElementById('regError');

//Action with click on overlay
overlay.addEventListener("click", function () {
    overlay.style.display = "none";
    confirmBox.style.display = "none";
});
overlay1.addEventListener("click", function () {
    overlay1.style.display = "none";
    confirmBox1.style.display = "none";
});
overlay2.addEventListener("click", function () {
    overlay2.style.display = "none";
    confirmBox2.style.display = "none";
});

// Thêm sự kiện click cho nút log-out
const logoutform = document.getElementById('logout-form');

logoutform.addEventListener('click', () => {
    event.preventDefault();
    confirmBox2.style.display = "block";
    overlay2.style.display = "block";
    yesButton2.addEventListener("click", function () {
        // Perform delete action
        confirmBox2.style.display = "none";
        overlay2.style.display = "none";
        logoutform.submit();
    });
    noButton2.addEventListener("click", function () {
        confirmBox2.style.display = "none";
        overlay2.style.display = "none";
    });
});

// Thêm sự kiện click cho nút chỉnh sửa của form 1
form1editButton.addEventListener('click', () => {
    for (const input of form1Inputs) {
        input.removeAttribute('readonly');
    }
    form1submitButton.style.display = '';
    form1editButton.style.display = 'none';
});
//  Thêm sự kiện click cho nút chỉnh sửa của form 2
form2editButton.addEventListener('click', () => {
    for (const input of form2Inputs) {
        input.removeAttribute('readonly');
    }
    form2submitButton.style.display = '';
    form2editButton.style.display = 'none';
});
//---------------------------------------------------------------------------------------------------------------------------------------------
//Lang nghe su kien tu form 2
form.addEventListener('submit', (event) => {
    // Check if any of the password fields are empty
    if (currentPasswordInput.value === '' || newPasswordInput.value === '' || confirmPasswordInput.value === '') {
        event.preventDefault();
        mySpan1.dataset.myAttribute = 'Please fill out all password fields.';
        mainFunction();
        return;
    }
    // Check if the new password and confirm password fields match
    if (newPasswordInput.value !== confirmPasswordInput.value) {
        event.preventDefault();
        mySpan1.dataset.myAttribute = 'New password and confirm password do not match!';
        mainFunction();
        return;
    }
    // Check if the new password field meets the password criteria
    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$/;
    if (!passwordRegex.test(currentPasswordInput.value)) {
        event.preventDefault();
        mySpan1.dataset.myAttribute = 'Current password must contain at least one uppercase letter, one lowercase letter, and one number.';
        mainFunction();
        return;
    } else if (!passwordRegex.test(newPasswordInput.value)) {
        event.preventDefault();
        mySpan1.dataset.myAttribute = "New password must contain at least one uppercase letter, one lowercase letter, and one number.";
        mainFunction();
        return;
    } else {
        event.preventDefault();
        confirmBox1.style.display = "block";
        overlay1.style.display = "block";
        yesButton1.addEventListener("click", function () {
            // Perform delete action
            confirmBox1.style.display = "none";
            overlay1.style.display = "none";
            form.submit();
        });
        noButton1.addEventListener("click", function () {
            confirmBox1.style.display = "none";
            overlay1.style.display = "none";
        });
    }
});
//--------------------------------------------------------------------------------------------------------------------------------------
function update() {
    var fullname = document.getElementById("fullname").value;
    var email = document.getElementById("email").value;
    var phone = document.getElementById("phone").value;
    var answer = document.getElementById("SecurityAnswer").value;
    var error = "";
    if (fullname !== "" && email !== "" && phone !== "" && answer !== "") {
        var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        if (re.test(String(email).toLowerCase()) === true) {
            var phoneRegex = /^\d{10}$|^\d{3}-\d{3}-\d{4}$|^\d{3} \d{3} \d{4}$/;
            if (phoneRegex.test(phone) === true) {
                if (answer.length >= 5 && answer.length <= 30) {
                    event.preventDefault();
                    confirmBox.style.display = "block";
                    overlay.style.display = "block";
                    yesButton.addEventListener("click", function () {
                        // Perform delete action
                        confirmBox.style.display = "none";
                        overlay.style.display = "none";
                        form1.submit();
                    });
                    noButton.addEventListener("click", function () {
                        confirmBox.style.display = "none";
                        overlay.style.display = "none";
                    });
                } else {
                    mySpan.dataset.myAttribute = "Answer must be between 5 and 30 characters!";
                    mainFunction();
                    return false;
                }
            } else {
                mySpan.dataset.myAttribute = "Phone number is not valid!";
                mainFunction();
                return false;
            }
        } else {
            mySpan.dataset.myAttribute = "Email is not valid!";
            mainFunction();
            return false;
        }
    } else {
        mySpan.dataset.myAttribute = "Please fill all information account to update!";
        mainFunction();
        return false;
    }
}
mainFunction();
function mainFunction() {
    const myAttribute = mySpan.getAttribute('data-my-attribute');
    const myAttribute1 = mySpan1.getAttribute('data-my-attribute');
    if (myAttribute === "Yes") {
        showSuccessInfToast();
    } else if (myAttribute === "No") {
        showErrorInfToast();
    } else if (myAttribute !== "") {
        showError(myAttribute);
    } else if (myAttribute1 === "Noo") {
        showErrorsOldToast();
    } else if (myAttribute1 === "No") {
        showErrorPassToast();
    } else if (myAttribute1 === "Yes") {
        showSuccessPassToast();
    } else if (myAttribute1 !== "") {
        showErrorPass(myAttribute1);
    } else {
        return;
    }
}


function showError(myAttribute) {
    toast({
        title: 'Error!',
        message: myAttribute,
        type: 'error',
        duration: 3000
    });
}

function showErrorPass(myAttribute1) {
    toast({
        title: 'Error!',
        message: myAttribute1,
        type: 'error',
        duration: 3000
    });
}

function showSuccessInfToast() {
    toast({
        title: 'Successfully!',
        message: 'Update information successfully!',
        type: 'success',
        duration: 3000
    });
}

function showErrorInfToast() {
    toast({
        title: 'Failed!',
        message: 'Update information Unsuccessfully!',
        type: 'error',
        duration: 3000
    });
}

function showSuccessPassToast() {
    toast({
        title: 'Successfully!',
        message: 'Change Password Successfully!',
        type: 'success',
        duration: 3000
    });
}
function showErrorsOldToast() {
    toast({
        title: 'Failed!!',
        message: 'Your current password is not correct!',
        type: 'error',
        duration: 3000
    });
}

function showErrorPassToast() {
    toast({
        title: 'Failed!',
        message: 'Change Password Unsuccessfully!',
        type: 'error',
        duration: 3000
    });
}
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
// Lấy các thẻ input và nút chỉnh sửa từ form 1 va form 2
const form1Inputs = document.querySelectorAll('#form-1 .editable');
const form2Inputs = document.querySelectorAll('#form-2 .editable');
const form1editButton = document.getElementById('edit-button');
const form1 = document.getElementById('form-1');
const form1submitButton = document.getElementById('submit-button');
const form2editButton = document.getElementById('edit-pass-button');
const form2submitButton = document.getElementById('submit-pass-button');
//form 2
const form = document.querySelector('#form-2');
const currentPasswordInput = form.querySelector('#input-oldpassword');
const newPasswordInput = form.querySelector('#input-newpassword');
const confirmPasswordInput = form.querySelector('#input-confirmpassword');
const errorSpan = document.querySelector('#regError');

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
        errorSpan.innerText = 'Please fill out all password fields.';
        return;
    }
    // Check if the new password and confirm password fields match
    if (newPasswordInput.value !== confirmPasswordInput.value) {
        event.preventDefault();
        errorSpan.innerText = 'New password and confirm password do not match!';
        return;
    }
    // Check if the new password field meets the password criteria
    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$/;
    if (!passwordRegex.test(currentPasswordInput.value)) {
        event.preventDefault();
        errorSpan.innerText = 'Current password must contain at least one uppercase letter, one lowercase letter, and one number.';
        return;
    } else if (!passwordRegex.test(newPasswordInput.value)) {
        event.preventDefault();
        errorSpan.innerText = 'New password must contain at least one uppercase letter, one lowercase letter, and one number.';
        return;
    } else {
        // All password checks have passed
        errorSpan.innerText = '';
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
    if (fullname != "" && email != "" && phone != "" && answer != "") {
        var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        if (re.test(String(email).toLowerCase()) == true) {
            var phoneRegex = /^\d{10}$|^\d{3}-\d{3}-\d{4}$|^\d{3} \d{3} \d{4}$/;
            if (phoneRegex.test(phone) == true) {
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
                    document.getElementById("regError1").innerText =
                            "Answer must be between 5 and 30 characters!";
                    return false;
                }
            } else {
                document.getElementById("regError1").innerText =
                        "Phone number is not valid!";
                return false;
            }
        } else {
            document.getElementById("regError1").innerText = "Email is not valid!";
            return false;
        }
    } else {
        document.getElementById("regError1").innerText = "Please fill all information account to update!";
        return false;
    }
}
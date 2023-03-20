
const mySpan1 = document.getElementById('regError');

function mainFunction() {
    const myAttribute1 = mySpan1.getAttribute('data-my-attribute');
    if (myAttribute1 !== "") {
        showSuccessInfToast(myAttribute1);
    }
}

function showSuccessInfToast(myAttribute1) {
    toast({
        title: 'Error!',
        message: myAttribute1,
        type: 'error',
        duration: 3000
    });
}

//Validate when click login button
function register() {
    var fullname = document.getElementById("fullname").value;
    var email = document.getElementById("email").value;
    var username = document.getElementById("username").value;
    var password = document.getElementById("password").value;
    var confirmPassword = document.getElementById("confirmPassword").value;
    var phone = document.getElementById("phoneNumber").value;
    var answer = document.getElementById("securityAnswer").value;
    if (fullname != "" && username != "" && password != "" && confirmPassword != "" && email != "" && phone != "" && answer != "") {
        var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        if (re.test(String(email).toLowerCase()) == true) {
            if (username.length >= 5 && username.length <= 30) {
                var firstChar = username.charAt(0);
                var specialChars = /[^a-zA-Z0-9]/g;
                var numbers = /[0-9]/g;
                if (!numbers.test(firstChar) && !specialChars.test(firstChar)) {
                    if (password.length >= 5 && password.length <= 30) {
                        var lowerCase = /[a-z]/g;
                        var upperCase = /[A-Z]/g;
                        var numbers = /[0-9]/g;
                        if (lowerCase.test(password) && upperCase.test(password) && numbers.test(password)) {
                            if (confirmPassword.length >= 5 && confirmPassword.length <= 30) {
                                var lowerCase = /[a-z]/g;
                                var upperCase = /[A-Z]/g;
                                var numbers = /[0-9]/g;
                                if (lowerCase.test(confirmPassword) && upperCase.test(confirmPassword) && numbers.test(confirmPassword)) {
                                    if (confirmPassword == password) {
                                        var phoneRegex = /^\d{10}$|^\d{3}-\d{3}-\d{4}$|^\d{3} \d{3} \d{4}$/;
                                        if (phoneRegex.test(phone) == true) {
                                            if (answer.length >= 5 && answer.length <= 30) {

                                            } else {
                                                mySpan1.dataset.myAttribute = "Answer must be between 5 and 30 characters!";
                                                mainFunction();
                                                return false;
                                            }
                                        } else {
                                            mySpan1.dataset.myAttribute = "Phone number is not valid!";
                                            mainFunction();
                                            return false;
                                        }
                                    } else {
                                        mySpan1.dataset.myAttribute = "Confirm Password not the same with Password!";
                                        mainFunction();
                                        return false;
                                    }
                                } else {
                                    mySpan1.dataset.myAttribute = "Confirm Password must include at least one lowercase letter, one uppercase letter, and one number!";
                                    mainFunction();
                                    return false;
                                }
                            } else {
                                mySpan1.dataset.myAttribute = "Confirm Password must be between 5 and 30 characters!";
                                mainFunction();
                                return false;
                            }
                        } else {
                            mySpan1.dataset.myAttribute = "Password must include at least one lowercase letter, one uppercase letter, and one number!";
                            mainFunction();
                            return false;
                        }
                    } else {
                        mySpan1.dataset.myAttribute = "Password must be between 5 and 30 characters!";
                        mainFunction();
                        return false;
                    }
                } else {
                    mySpan1.dataset.myAttribute = "Username must start with a letter!";
                    mainFunction();
                    return false;
                }
            } else {
                mySpan1.dataset.myAttribute = "Username must be between 5 and 30 characters!";
                mainFunction();
                return false;
            }
        } else {
            mySpan1.dataset.myAttribute = "Email is not valid!";
            mainFunction();
            return false;
        }
    } else {
        mySpan1.dataset.myAttribute = "Please fill all information account to register!";
        mainFunction();
        return false;
    }
}
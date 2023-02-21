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
                                                document.getElementById("regError").innerText =
                                                        "Answer must be between 5 and 30 characters!";
                                                return false;
                                            }
                                        } else {
                                            document.getElementById("regError").innerText =
                                                    "Phone number is not valid!";
                                            return false;
                                        }
                                    } else {
                                        document.getElementById("regError").innerText =
                                                "Confirm Password not the same with Password!";
                                        return false;
                                    }
                                } else {
                                    document.getElementById("regError").innerText =
                                            "Confirm Password must include at least one lowercase letter, one uppercase letter, and one number!";
                                    return false;
                                }
                            } else {
                                document.getElementById("regError").innerText = "Confirm Password must be between 5 and 30 characters!";
                                return false;
                            }
                        } else {
                            document.getElementById("regError").innerText =
                                    "Password must include at least one lowercase letter, one uppercase letter, and one number!";
                            return false;
                        }
                    } else {
                        document.getElementById("regError").innerText = "Password must be between 5 and 30 characters!";
                        return false;
                    }
                } else {
                    document.getElementById("regError").innerText = "Username must start with a letter!";
                    return false;
                }
            } else {
                document.getElementById("regError").innerText = "Username must be between 5 and 30 characters!";
                return false;
            }
        } else {
            document.getElementById("regError").innerText = "Email is not valid!";
            return false;
        }
    } else {
        document.getElementById("regError").innerText = "Please fill all information account to register!";
        return false;
    }
}
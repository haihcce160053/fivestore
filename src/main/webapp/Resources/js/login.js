//Validate when click login button
function login() {
    var username = document.getElementById("username").value;
    var password = document.getElementById("password").value;
    if (username != "" && password != "") {
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
                        // Your code to process a successful login
                    } else {
                        document.getElementById("loginError").innerText =
                                "Password must include at least one lowercase letter, one uppercase letter, and one number!";
                        return false;
                    }
                } else {
                    document.getElementById("loginError").innerText = "Password must be between 5 and 30 characters!";
                    return false;
                }
            } else {
                document.getElementById("loginError").innerText = "Username must start with a letter!";
                return false;
            }
        } else {
            document.getElementById("loginError").innerText = "Username must be between 5 and 30 characters!";
            return false;
        }
    } else {
        document.getElementById("loginError").innerText = "Please fill in your username and password!";
        return false;
    }
}

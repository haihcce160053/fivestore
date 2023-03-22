
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
function showSuccessToast(myAttribute1) {
    toast({
        title: 'Successfully!',
        message: myAttribute1,
        type: 'success',
        duration: 3000
    });
}

window.addEventListener("load", function () {
    const myAttribute1 = mySpan1.getAttribute('data-my-attribute');
    if (myAttribute1 === "Sign Up Successfully! You can sign in now!") {
        showSuccessToast(myAttribute1);
    } else if (myAttribute1 !== "") {
        showSuccessInfToast(myAttribute1);
    }
});

//Validate when click login button
function login() {
    var username = document.getElementById("username").value;
    var password = document.getElementById("password").value;
    if (username !== "" && password !== "") {
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
        mySpan1.dataset.myAttribute = "Please fill in your username and password!";
        mainFunction();
        return false;
    }
}

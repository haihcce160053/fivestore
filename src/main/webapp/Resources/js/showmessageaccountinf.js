const mySpan = document.getElementById('regError1');
const mySpan1 = document.getElementById('regError');
const myAttribute = mySpan.getAttribute('data-my-attribute');
const myAttribute1 = mySpan1.getAttribute('data-my-attribute');

mainFunction();
function mainFunction() {
    if (myAttribute == "Yes") {
        showSuccessInfToast();
    } else if (myAttribute == "No") {
        showErrorInfToast();
    } else if (myAttribute1 == "Noo") {
        showErrorsOldToast();
    } else if (myAttribute1 == "No") {
        showErrorPassToast();
    } else if (myAttribute1 == "Yes") {
        showSuccessPassToast();
    } else {
        return;
    }
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
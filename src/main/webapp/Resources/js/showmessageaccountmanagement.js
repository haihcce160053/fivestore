const mySpan1 = document.getElementById('regError');
const myAttribute1 = mySpan1.getAttribute('data-my-attribute');
mainFunction();

function mainFunction() {
    if (myAttribute1 == "Noo") {
        showErrorDeleteAdToast();
    } else if (myAttribute1 == "YesD") {
        showSuccessDeleteToast();
    } else if (myAttribute1 == "NoD") {
        showErrorDeleteToast();
    } else if (myAttribute1 == "Nooo") {
        showErrorChangeAdminToast();
    } else if (myAttribute1 == "YesC") {
        showSuccessChangeCusToast();
    } else if (myAttribute1 == "NoC") {
        showErrorChangeCusToast();
    } else if (myAttribute1 == "YesA") {
        showSuccessChangeAdToast();
    } else if (myAttribute1 == "NoA") {
        showErrorChangeAdToast();
    } else {
        return;
    }
}

function showErrorDeleteAdToast() {
    toast({
        title: 'Failed!',
        message: 'You cannot delete account ADMIN!',
        type: 'error',
        duration: 3000
    });
}

function showSuccessDeleteToast() {
    toast({
        title: 'Successfully!',
        message: 'Delete Account Successfully!',
        type: 'success',
        duration: 3000
    });
}
function showErrorDeleteToast() {
    toast({
        title: 'Failed!!',
        message: 'Delete Account Unsuccessfully!',
        type: 'error',
        duration: 3000
    });
}

function showErrorChangeAdminToast() {
    toast({
        title: 'Failed!',
        message: 'You cannot change permission account ADMIN!',
        type: 'error',
        duration: 3000
    });
}

function showSuccessChangeAdToast() {
    toast({
        title: 'Successfully!',
        message: 'Change Permission Account To Admin Successfully!',
        type: 'success',
        duration: 3000
    });
}
function showSuccessChangeCusToast() {
    toast({
        title: 'Successfully!',
        message: 'Change Permission Account To Customer Successfully!',
        type: 'success',
        duration: 3000
    });
}



function showErrorChangeAdToast() {
    toast({
        title: 'Failed!',
        message: 'Change Permission Account To Admin Unsuccessfully!',
        type: 'error',
        duration: 3000
    });
}

function showErrorChangeCusToast() {
    toast({
        title: 'Failed!',
        message: 'Change Permission Account To Customer Unsuccessfully!',
        type: 'error',
        duration: 3000
    });
}


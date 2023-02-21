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
    } else {
        return;
    }
}

function showErrorDeleteAdToast() {
    toast({
        title: 'Failed!',
        message: 'You cannot delete this order!',
        type: 'error',
        duration: 3000
    });
}

function showSuccessDeleteToast() {
    toast({
        title: 'Successfully!',
        message: 'Delete Order Successfully!',
        type: 'success',
        duration: 3000
    });
}
function showErrorDeleteToast() {
    toast({
        title: 'Failed!!',
        message: 'Delete Order Unsuccessfully!',
        type: 'error',
        duration: 3000
    });
}



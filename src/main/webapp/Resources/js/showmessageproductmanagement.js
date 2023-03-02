/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/ClientSide/javascript.js to edit this template
 */
//Hoang Liem

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
    } else if (myAttribute1 == "YesA") {
        showSuccessAddToast();
    } else if (myAttribute1 == "YesU") {
        showSuccessUpdateToast();
    } else {
        return;
    }
}

function showErrorDeleteAdToast() {
    toast({
        title: 'Failed!',
        message: 'Not find Product!',
        type: 'error',
        duration: 3000
    });
}

function showSuccessDeleteToast() {
    toast({
        title: 'Successfully!',
        message: 'Delete Product Successfully!',
        type: 'success',
        duration: 3000
    });
}
function showErrorDeleteToast() {
    toast({
        title: 'Failed!!',
        message: 'Delete Product Unsuccessfully!',
        type: 'error',
        duration: 3000
    });
}


function showSuccessAddToast() {
    toast({
        title: 'Successfully!',
        message: 'Add Product Successfully!',
        type: 'success',
        duration: 3000
    });
}

function showSuccessUpdateToast() {
    toast({
        title: 'Successfully!',
        message: 'Update Product Successfully!',
        type: 'success',
        duration: 3000
    });
}




/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/ClientSide/javascript.js to edit this template
 */
const mySpan1 = document.getElementById('regError');
const myAttribute1 = mySpan1.getAttribute('data-my-attribute');
console.log(myAttribute1);
mainFunction();

function mainFunction() {
    if (myAttribute1 == "Noo") {
        ShowErrorNotCancel();
    } else if (myAttribute1 == "YesD") {
        showSuccessCancel();
    } else if (myAttribute1 == "NoD") {
        showErrorCancel();
    } else if (myAttribute1 == "Not") {
        showOrderToast();
    } else if (myAttribute1 == "YesR") {
        showSuccessReorder();
    } else if (myAttribute1 == "NoR") {
        showErrorReorder();
    } else if (myAttribute1 == "NooR") {
        showErrorReorder();
    } else {
        return;
    }
}

function ShowErrorNotCancel() {
    toast({
        title: 'You cannot cancel this order!',
        message: 'You can only cancel if the order is in the status of confirmation!',
        type: 'error',
        duration: 5000
    });
}

function showSuccessCancel() {
    toast({
        title: 'Successfully!',
        message: 'Cancel Order Successfully!',
        type: 'success',
        duration: 3000
    });
}
function showErrorCancel() {
    toast({
        title: 'Failed!!',
        message: 'Cancel Order Unsuccessfully!',
        type: 'error',
        duration: 3000
    });
}

function showOrderToast() {
    toast({
        title: 'Notice!',
        message: 'You do not have any orders!',
        type: 'error',
        duration: 3000
    });
}
function showSuccessReorder() {
    toast({
        title: 'Successfully!',
        message: 'Re-Order Successfully!',
        type: 'success',
        duration: 3000
    });
}
function showErrorReorder() {
    toast({
        title: 'Failed!!',
        message: 'Re-Order Unsuccessfully!',
        type: 'error',
        duration: 3000
    });
}


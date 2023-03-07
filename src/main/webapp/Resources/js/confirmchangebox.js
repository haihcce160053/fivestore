/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
// Xy ly overlay
const overlay = document.getElementById("overlay");
overlay.addEventListener("click", function () {
    overlay.style.display = "none";
    const confirmBox = document.getElementById("confirm-box");
    confirmBox.style.display = "none";
});
const overlay1 = document.getElementById("overlay1");
overlay1.addEventListener("click", function () {
    overlay1.style.display = "none";
    const confirmBox1 = document.getElementById("confirm-box1");
    confirmBox1.style.display = "none";
});
// Get all the a tags
const aTags = document.querySelectorAll("a");
const aTag = document.querySelector('a.edit');
const aTag1 = document.querySelector('a.delete');
// Add event listener to each a tag
aTags.forEach((aTag) => {
    aTag.addEventListener("click", (event) => {
        // Get the href of the link that was clicked
        const href = aTag.getAttribute("href");
        // Check if the link is for changing permission or deleting account
        if (href.includes("Change")) {
            // Display the change permission confirm box
            document.getElementById("overlay").style.display = "block";
            document.getElementById("confirm-box").style.display = "block";
            event.preventDefault();
            document.getElementById("yes-button").addEventListener("click", () => {
                document.getElementById("overlay").style.display = "none";
                document.getElementById("confirm-box").style.display = "none";
                window.location.href = href;
            });
        }
    });
});
aTags.forEach((aTag1) => {
    aTag1.addEventListener("click", (event) => {
        // Get the href of the link that was clicked
        const href1 = aTag1.getAttribute("href");
        if (href1.includes("Delete")) {
            // Display the delete account confirm box
            document.getElementById("overlay1").style.display = "block";
            document.getElementById("confirm-box1").style.display = "block";
            event.preventDefault();
            document.getElementById("yes-button1").addEventListener("click", () => {
                // Hide the confirmation box
                document.getElementById("overlay1").style.display = "none";
                document.getElementById("confirm-box1").style.display = "none";
                window.location.href = href1;
            });
        }
    });
});
// Add event listener to the "No" buttons to hide the confirm boxes
document.getElementById("no-button").addEventListener("click", () => {
    document.getElementById("overlay").style.display = "none";
    document.getElementById("confirm-box").style.display = "none";
});
document.getElementById("no-button1").addEventListener("click", () => {
    document.getElementById("overlay1").style.display = "none";
    document.getElementById("confirm-box1").style.display = "none";
});

// Get all the option tags
// Get the select tag
const selectTag = document.querySelector('#selectStatus');

// Add event listener to select tag
selectTag.addEventListener('change', (event) => {
    event.preventDefault();
    // Get the selected option tag
    const selectedOption = selectTag.options[selectTag.selectedIndex];
    // Get the href of the selected option tag
    const href = selectedOption.getAttribute('href');
    // Check if the href is for changing permission
    if (href.includes('Change')) {
// Display the change permission confirm box
        document.getElementById('overlay').style.display = 'block';
        document.getElementById('confirm-box').style.display = 'block';
        // Add event listener to the "Yes" button
        document.getElementById('yes-button').addEventListener('click', () => {
            document.getElementById('overlay').style.display = 'none';
            document.getElementById('confirm-box').style.display = 'none';
            window.location.href = href;
        });
    }
});
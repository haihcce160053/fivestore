//Quang Qui

// Get the search input element
var input = document.getElementById("search");

// Add event listener to the search input
input.addEventListener("keyup", function () {
    // Get the filter value from the search input
    var filter = input.value.toUpperCase();

    // Get the table rows
    var rows = document.getElementsByClassName("table-row");

    // Loop through the rows and hide/show based on filter value
    for (var i = 0; i < rows.length; i++) {
        var username = rows[i].getElementsByClassName("col-1")[0].textContent.toUpperCase();
        if (username.indexOf(filter) > -1) {
            rows[i].style.display = "";
        } else {
            rows[i].style.display = "none";
        }
    }
});

/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/ClientSide/javascript.js to edit this template
 */
const selectElement = document.getElementById("AllSelect");
const tableRows = document.querySelectorAll(".table-row");

selectElement.addEventListener("change", (event) => {
    const selectedValue = event.target.value;
    tableRows.forEach((row) => {
        const statusElement = row.querySelector('select[id="selectStatus"]');
        const statusValue = statusElement.value;
        console.log(statusValue);
        if (selectedValue === "All" || selectedValue === statusValue) {
            row.style.display = "flex";
        } else {
            row.style.display = "none";
        }
    });
});
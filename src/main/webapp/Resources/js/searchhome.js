//Quang Qui
const inputSearch = document.querySelector('input[aria-label="Search"]');

inputSearch.addEventListener('input', () => {
    const searchText = inputSearch.value.toLowerCase();
    const productTitles = document.querySelectorAll('.card-title');

    productTitles.forEach(title => {
        const titleText = title.textContent.toLowerCase();
        const card = title.closest('.card');

        if (titleText.includes(searchText)) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });
});



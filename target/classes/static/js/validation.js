document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("tdeeForm");

    form.addEventListener("submit", function (event) {
        if (!form.checkValidity()) {
            event.preventDefault(); // Voorkom verzenden als niet geldig
            event.stopPropagation();
        }

        form.classList.add("was-validated"); // Bootstrap-stijl activeren
    }, false);
});

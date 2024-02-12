document.addEventListener("DOMContentLoaded", function () {

    const next = document.querySelectorAll('[id=next]');

    let arrayCounter = 0;

    const site0 = document.getElementById("site0");
    const site1 = document.getElementById("site1");
    const site2 = document.getElementById("site2");
    const site3 = document.getElementById("site3");
    const site4 = document.getElementById("site4");
    const site5 = document.getElementById("site5");
    const site6 = document.getElementById("site6");

    const preview = [site0, site1, site2, site3, site4, site5, site6];

    next.forEach(button => {
        button.addEventListener('click', () => {
            arrayCounter++;
            preview.forEach(element => {
                element.style.display = "none";
            })
            preview[arrayCounter].style.display = "block";
        })
    })
});
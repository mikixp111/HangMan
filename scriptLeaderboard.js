document.addEventListener("DOMContentLoaded", function () {

    const firstPlayerButton = document.getElementById("firstPlayerButton");
    const secondPlayerButton = document.getElementById("secondPlayerButton");
    const thirdPlayerButton = document.getElementById("thirdPlayerButton");

    const firstPlayer = document.getElementById("firstPlayer");
    const secondPlayer = document.getElementById("secondPlayer");
    const thirdPlayer = document.getElementById("thirdPlayer");

    const preview = [firstPlayer, secondPlayer, thirdPlayer];

    const close = document.querySelectorAll('[id=close]');

    const map = new Map([
        [firstPlayerButton, firstPlayer],
        [secondPlayerButton, secondPlayer],
        [thirdPlayerButton, thirdPlayer]
    ]);

    map.forEach(function (value, key) {
        key.addEventListener('click', () => {
            preview.forEach(element => {
                element.style.display = "none";
            })
            value.style.display = "block";
        })
    })
    
    close.forEach(button => {
        button.addEventListener('click', () => {
            preview.forEach(element => {
                element.style.display = "none";
            })
        })
    })
});
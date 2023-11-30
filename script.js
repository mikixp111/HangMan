document.addEventListener("DOMContentLoaded", function () {
    
    const hangMan = document.getElementById("hangMan");

    if (!hangMan) {
        return;
    }

    hangMan.addEventListener("click", function (event) {

        const date = new Date();

        const formattedDate = date.toLocaleString('de-DE');

        event.target.dispatchEvent(new CustomEvent("notify", {
            bubbles: true,
            detail: {
                text: formattedDate + " - HangMan!"
            },
        }));

    });

});

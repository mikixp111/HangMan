document.addEventListener("DOMContentLoaded", function () {

    const itemZero = document.getElementById("itemZero");
    const itemOne = document.getElementById("itemOne");
    const itemTwo = document.getElementById("itemTwo");
    const itemThree = document.getElementById("itemThree");
    const itemFour = document.getElementById("itemFour");
    const itemFive = document.getElementById("itemFive");
    const itemSix = document.getElementById("itemSix");

    const inventoryOnStart = document.getElementById("inventoryOnStart");
    const firstItem = document.getElementById("firstItem");
    const secondItem = document.getElementById("secondItem");
    const thirdItem = document.getElementById("thirdItem");
    const fourthItem = document.getElementById("fourthItem");
    const fifthItem = document.getElementById("fifthItem");
    const sixthItem = document.getElementById("sixthItem");
    const defaultItem = document.getElementById("defaultItem");

    const preview = [defaultItem, firstItem, secondItem, thirdItem, fourthItem, fifthItem, sixthItem, inventoryOnStart];

    const map = new Map([
        [itemZero, defaultItem],
        [itemOne, firstItem],
        [itemTwo, secondItem],
        [itemThree, thirdItem],
        [itemFour, fourthItem],
        [itemFive, fifthItem],
        [itemSix, sixthItem]
    ]);
    map.forEach(function (value, key) {
        key.addEventListener('click', () => {
            preview.forEach(element => {
                element.style.display = "none";
            })
            value.style.display = "block";
        })
    })

});
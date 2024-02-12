document.addEventListener("DOMContentLoaded", function () {
    
    const wordLength = document.getElementById("wordLength").textContent;
    
    let firstLetter = document.getElementById("firstLetter").textContent;
    let secondLetter = document.getElementById("secondLetter").textContent;
    let thirdLetter = document.getElementById("thirdLetter").textContent;
    let fourthLetter = 0;
    let fifthLetter = 0;
    let sixthLetter = 0;
    let seventhLetter = 0;
    let eightLetter = 0;
    let ninethLetter = 0;
    let tenthLetter = 0;

    if (wordLength > 3) {
        fourthLetter = document.getElementById("fourthLetter").textContent;
    }
    if (wordLength > 4) {
        fifthLetter = document.getElementById("fifthLetter").textContent;
    }
    if (wordLength > 5) {
        sixthLetter = document.getElementById("sixthLetter").textContent;
    }
    if (wordLength > 6) {
        seventhLetter = document.getElementById("seventhLetter").textContent;
    }
    if (wordLength > 7) {
        eightLetter = document.getElementById("eightLetter").textContent;
    }
    if (wordLength > 8) {
        ninethLetter = document.getElementById("ninethLetter").textContent;
    }
    if (wordLength > 9) {
        tenthLetter = document.getElementById("tenthLetter").textContent;
    }

    const wordLetters = [firstLetter, secondLetter, thirdLetter, fourthLetter, fifthLetter, sixthLetter, seventhLetter, eightLetter, ninethLetter, tenthLetter];

    let counter = 0;

    let wrongCounter = 0;

    const anim1 = document.getElementById("Anim1");
    const anim2 = document.getElementById("Anim2");
    const anim3 = document.getElementById("Anim3");
    const anim4 = document.getElementById("Anim4");
    const anim5 = document.getElementById("Anim5");
    const anim6 = document.getElementById("Anim6");
    const anim7 = document.getElementById("Anim7");
    const anim8 = document.getElementById("Anim8");

    const animArray = [anim1, anim2, anim3, anim4, anim5, anim6, anim7, anim8];

    const first = document.getElementById("firstLetter");
    const second = document.getElementById("secondLetter");
    const third = document.getElementById("thirdLetter");
    const fourth = document.getElementById("fourthLetter");
    const fifth = document.getElementById("fifthLetter");
    const sixth = document.getElementById("sixthLetter");
    const seventh = document.getElementById("seventhLetter");
    const eight = document.getElementById("eightLetter");
    const nineth = document.getElementById("ninethLetter");
    const tenth = document.getElementById("tenthLetter");

    const letterCorrect = [first, second, third, fourth, fifth, sixth, seventh, eight, nineth, tenth];

    const tries = 8;

    const youLost = document.getElementById("youLost");

    const youWon = document.getElementById("youWon");

    const keyA = document.getElementById("keyA");
    const keyB = document.getElementById("keyB");
    const keyC = document.getElementById("keyC");
    const keyD = document.getElementById("keyD");
    const keyE = document.getElementById("keyE");
    const keyF = document.getElementById("keyF");
    const keyG = document.getElementById("keyG");
    const keyH = document.getElementById("keyH");
    const keyI = document.getElementById("keyI");
    const keyJ = document.getElementById("keyJ");
    const keyK = document.getElementById("keyK");
    const keyL = document.getElementById("keyL");
    const keyM = document.getElementById("keyM");
    const keyN = document.getElementById("keyN");
    const keyO = document.getElementById("keyO");
    const keyP = document.getElementById("keyP");
    const keyQ = document.getElementById("keyQ");
    const keyR = document.getElementById("keyR");
    const keyS = document.getElementById("keyS");
    const keyT = document.getElementById("keyT");
    const keyU = document.getElementById("keyU");
    const keyV = document.getElementById("keyV");
    const keyW = document.getElementById("keyW");
    const keyX = document.getElementById("keyX");
    const keyY = document.getElementById("keyY");
    const keyZ = document.getElementById("keyZ");

    const keyboard = [keyA, keyB, keyC, keyD, keyE, keyF, keyG, keyH, keyI, keyJ, keyK, keyL, keyM, keyN, keyO, keyP, keyQ, keyR, keyS, keyT, keyU, keyV, keyW, keyX, keyY, keyZ];

    keyboard.forEach(btn => {
        btn.addEventListener('click', () => {
            btn.style.borderColor = "#cbd5e1";
            btn.style.color = "#cbd5e1";
            btn.style.cursor = "default";
            btn.style.backgroundColor = "#f1f5f9";
            btn.style.pointerEvents = "none";
            for (let i = 0; i < wordLetters.length; i++) {
                if (btn.textContent == wordLetters[i]) {
                    letterCorrect[i].style.display = "block";
                    counter++;
                    if ( counter == wordLength) {
                        youWon.style.visibility = "visible";
                    }
                }
            }
            if (btn.textContent !== firstLetter && btn.textContent !== secondLetter && btn.textContent !== thirdLetter && btn.textContent !== fourthLetter && btn.textContent !== fifthLetter && btn.textContent !== sixthLetter && btn.textContent !== seventhLetter && btn.textContent !== eightLetter && btn.textContent !== ninethLetter && btn.textContent !== tenthLetter) {
                wrongCounter++;
                document.getElementById("demo1").innerHTML = tries - wrongCounter;
                for (let i = 0; i < tries; i++) {
                    if (wrongCounter == i) {
                        animArray[i-1].style.visibility = "visible";
                    }
                }
                if ( wrongCounter == tries) {
                    youLost.style.visibility = "visible";
                }
            }
        })
    })
});

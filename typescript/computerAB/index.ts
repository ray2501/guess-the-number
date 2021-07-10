import readlineSync from 'readline-sync';

let resultset: Array<string> = [];

for (let i = 0; i < 10; i++) {
    for (let j = 0; j < 10; j++) {
        for (let k = 0; k < 10; k++) {
            for (let m = 0; m < 10; m++) {
                if (i != j && i != k && i != m && j != k && j != m && m != k) {
                    let result: string = i.toString() + j.toString() + k.toString() + m.toString();
                    resultset.push(result);
                }
            }
        }
    }
}

function getA(answer: string, guess: string): number {
    let num: number = 0;

    // Juse return 0
    if (answer.length != guess.length) {
        return 0;
    }

    for (let count = 0; count < answer.length; count++) {
        if (answer[count] == guess[count]) {
            num++;
        }
    }

    return num;
}

function getB(answer: string, guess: string): number {
    let num: number = 0;

    // Juse return 0
    if (answer.length != guess.length) {
        return 0;
    }

    for (let count = 0; count < answer.length; count++) {
        for (let count2 = 0; count2 < guess.length; count2++) {
            if (answer[count] == guess[count2]) {
                if (count != count2) {
                    num++;
                }
            }
        }
    }

    return num;
}


while (true) {
    if (resultset.length == 0) {
        console.log("User give the wrong response!!!");
        break;
    }

    let index: number = Math.floor(Math.random() * Math.floor(resultset.length));
    let myanswer: string = resultset[index];

    console.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    console.log(">> My answer is " + myanswer);

    let aStr: string = readlineSync.question('>> Please input the A value: ');
    let aNum: number = Number(aStr);
    if (aStr.length != 1) {
        console.log("It is not a valid response.");
        continue;
    }

    let bStr: string = readlineSync.question('>> Please input the B value: ');
    let bNum: number = Number(bStr);
    if (bStr.length != 1) {
        console.log("It is not a valid response.");
        continue;
    }

    if (aNum == 4 && bNum == 0) {
        console.log('Guess the correct answer.');
        break;
    }

    let newresultset: Array<string> = [];
    resultset.forEach((element) => {
        let aFilter: number = getA(element, myanswer);
        let bFilter: number = getB(element, myanswer);

        if (aFilter == aNum && bFilter == bNum) {
            newresultset.push(element);
        }
    });

    resultset = newresultset;
    console.log("\n");
}

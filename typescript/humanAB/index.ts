import readline from 'readline';


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


let number: number = 0;
let nstr: string = "";

while (true) {
    number = Math.floor(Math.random() * Math.floor(10000));
    nstr = number.toString();
    if (nstr.length != 4) {
        continue
    }

    if (nstr[0] != '0' && nstr[0] != nstr[1] && nstr[0] != nstr[2]
        && nstr[0] != nstr[3] && nstr[1] != nstr[2]
        && nstr[1] != nstr[3] && nstr[2] != nstr[3])
        break;
}

let rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
});

// This allows to prompt in loop until the answer is right
rl.setPrompt('Input the guess number: ');
rl.prompt()
rl.on('line', (line) => {
    if (line.length != 4) {
        console.log("It is not a valid data!!!")
    }

    let a = getA(nstr, line);
    let b = getB(nstr, line);
    console.log("The result is A = " + a + ", B = " + b + "\n");

    // The answer is correct
    if (a == 4 && b == 0) {
        rl.close();
        process.stdin.destroy();
    }

    rl.prompt();
}).on('close', () => {
    process.exit(0);
});

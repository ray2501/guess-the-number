#!/usr/bin/Rscript
getA <- function(str1, str2) {
    len1 <- nchar(str1)
    len2 <- nchar(str2)
    result <- 0

    if (len1 != len2) {
        return(0)
    }

    result <- 0
    for (i in c(1:4)) {
        if (substring(str1, i, i) == substring(str2, i, i)) {
            result <- result + 1
        }
    }

    return(result)
}

getB <- function(str1, str2) {
    len1 <- nchar(str1)
    len2 <- nchar(str2)
    result <- 0

    if (len1 != len2) {
        return(0)
    }

    result <- 0
    for (i in c(1:4)) {
        for (j in c(1:4)) {
            if (i != j) {
                if (substring(str1, i, i) == substring(str2, j, j)) {
                    result <- result + 1
                }
            }
        }
    }

    return(result)
}

results <- c()
for (i in c(0:9)) {
    for (j in c(0:9)) {
        for (k in c(0:9)) {
            for (m in c(0:9)) {
                if (i != j && i != k && i != m && j != k && j != m && k != m) {
                    cresult <- paste(toString(i), toString(j), toString(k), toString(m), sep = "")
                    results <- c(results, cresult)
                }
            }
        }
    }
}
item <- sample(length(results), 1)
answer <- results[item]
print(paste("My answer: ", answer))

repeat {
    cat("The A value is: ");
    con <- file("stdin")
    avalue <- readLines(con, n = 1)
    close(con)

    cat("The B value is: ");
    con <- file("stdin")
    bvalue <- readLines(con, n = 1)
    close(con)

    if (avalue == 4 && bvalue == 0) {
        print("Game over.")
        break
    }

    newresults <- c()
    for (value in results) {
        A <- getA(answer, value)
        B <- getB(answer, value)
        if (A == avalue && B == bvalue) {
            newresults <- c(newresults, value)
        }
    }

    results <- newresults

    if (length(results) > 0) {
        answer <- results[1]
        print(paste("My answer: ", answer))
    } else {
        print("Something is wrong!!!")
        break
    }
}

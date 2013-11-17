var n = 1;
var counter = 0;
search: while (true) {
    n += 1;
    for (var i = 2; i <= Math.sqrt(n) ; i += 1)
        if (n % i == 0)
            continue search;
    // found a prime!

    postMessage({ prime: n, counter: ++counter });
}
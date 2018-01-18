function Main(input) {
    var data = input.split("\n")
    
    var N = data[0]
    var D = data[1].split(" ")
    var X = parseInt(data[2].split(" ")[0])
    var Y = parseInt(data[2].split(" ")[1])
    var M = Math.abs(X) + Math.abs(Y)

    if (M == 0) {
        console.log(0)
        return
    }

    for (i = 0; i < N; i++) {
        D[i] = parseInt(D[i])
        if (D[i] == M) {
            console.log(1)
            return
        }
    }

    D.sort(function(a,b){
        if( a < b ) return -1;
        if( a > b ) return 1;
        return 0;
    });
    var p = [-1, -1]

    for (i = 0; i < N; i++) {
        var parity = Math.abs(D[i]-M) % 2
        if (p[parity] >= 0 && Math.abs(D[i] - p[parity]) <= M && M <= D[i] + p[parity]) {
            console.log(2)
            return
        }
        p[D[i]%2] = D[i]
        if (p[parity] >= 0 && Math.abs(D[i] - p[parity]) <= M && M <= D[i] + p[parity]) {
            console.log(2)
            return
        }
    }

    console.log(-1)
}

Main(require("fs").readFileSync("/dev/stdin", "utf8"));


import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, std.datetime;

immutable int N = 60;
immutable int K = 500;

void main() {
    auto start_time = Clock.currTime();

    readln.split;
    auto X = readln.split.map!(to!int).array;
    auto A = N.iota.map!(_ => readln.chomp.map!(a => a == '1').array).array;
    int[][] ops = new int[][](K);

    int[] search(int x) {
        int best_score = -100;
        int[][] best_ops;

        foreach (i; 0..N) {
            int score = 0;
            foreach (j; 0..X[x]) {
                score += A[i][j] ? 1 : -1;
            }
            if (score > best_score) {
                best_score = score;
                best_ops = [[i, 0, i, X[x]-1]];
            } else if (score == best_score) {
                best_ops ~= [i, 0, i, X[x]-1];
            }
            foreach (j; 1..N-X[x]+1) {
                score += A[i][j-1] ? -1 : 1;
                score += A[i][j+X[x]-1] ? 1 : -1;
                if (score > best_score) {
                    best_score = score;
                    best_ops = [[i, j, i, j+X[x]-1]];
                } else if (score == best_score) {
                    best_ops ~= [i, j, i, j+X[x]-1];
                }
            }
        }

        foreach (j; 0..N) {
            int score = 0;
            foreach (i; 0..X[x]) {
                score += A[i][j] ? 1 : -1;
            }
            if (score > best_score) {
                best_score = score;
                best_ops = [[0, j, X[x]-1, j]];
            } else if (score == best_score) {
                best_ops ~= [0, j, X[x]-1, j];
            }
            foreach (i; 1..N-X[x]+1) {
                score += A[i-1][j] ? -1 : 1;
                score += A[i+X[x]-1][j] ? 1 : -1;
                if (score > best_score) {
                    best_score = score;
                    best_ops = [[i, j, i+X[x]-1, j]];
                } else if (score == best_score) {
                    best_ops ~= [i, j, i+X[x]-1, j];
                }
            }
        }

        return best_ops[uniform(0, best_ops.length)];
    }

    auto hoge = K.iota.array;
    hoge.randomShuffle;
    //hoge.sort!((a, b) => X[a] > X[b]);

    foreach (x; hoge) {
        ops[x] = search(x);
        foreach (i; ops[x][0]..ops[x][2]+1)
            foreach (j; ops[x][1]..ops[x][3]+1)
                A[i][j] ^= 1;
    }

    debug { int loop_cnt; int improved_cnt; }
    while ((Clock.currTime - start_time).total!"msecs" < dur!"msecs"(980).total!"msecs") {
        int x = uniform(0, K);
        debug { int score; }

        foreach (i; ops[x][0]..ops[x][2]+1)
            foreach (j; ops[x][1]..ops[x][3]+1) {
                debug { score += A[i][j] ? 1 : -1; }
                A[i][j] ^= 1;
            }

        ops[x] = search(x);

        foreach (i; ops[x][0]..ops[x][2]+1)
            foreach (j; ops[x][1]..ops[x][3]+1) {
                debug { score += A[i][j] ? 1 : -1; }
                A[i][j] ^= 1;
            }

        debug { loop_cnt += 1; if (score > 0) improved_cnt += 1; }
    }

    debug { writeln(improved_cnt, " / ", loop_cnt); }


    foreach (op; ops)
        op.map!(a => (a+1).to!string).join(" ").writeln;
}


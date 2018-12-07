import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip, core.stdc.string;

immutable int[4] dr = [-1, 0, 1, 0];
immutable int[4] dc = [0, 1, 0, -1]; // 右回り

immutable int N = 500;
immutable int M = 29;
immutable int L = 300;
string[N] S;
dchar[M][M] A;
int[M*M] cnt;

immutable trying = 2100;
string init_masu = ".LR";
string change_masu = ".LR";

void main() {
    input;
    init;
    search;
    debug{score.writeln;}
    output;
}

void search() {
    int current_score = score;
    foreach (_; 0..trying) {
        int r = uniform(1, M-1);
        int c = uniform(1, M-1);
        dchar old_masu = A[r][c];
        dchar new_masu;
        do {
            new_masu = change_masu[uniform(0, change_masu.length)];
        } while (new_masu == old_masu);
        A[r][c] = new_masu;
        int new_score = score;
        if (new_score >= current_score) {
            current_score = new_score;
        } else {
            A[r][c] = old_masu;
        }
    }
}

int score() {
    int ans = 0;
    cnt[] = 0;
    foreach (s; S) {
        cnt[simulate(s)] += 1;
    }
    foreach (i; 0..M*M) {
        if (cnt[i] == 1) ans += 10;
        else if (cnt[i] == 2) ans += 3;
        else if (cnt[i] == 3) ans += 1;
    }
    return ans;
}

int simulate(ref string s) {
    int r = 14;
    int c = 14;
    int d = 0;
    foreach (com; s) {
        int rep = 1;
        if (A[r][c] == 'D') rep = 2;
        if (A[r][c] == 'T') rep = 3;
        if (com == 'S') {
            foreach (_; 0..rep) {
                int nr = r + dr[d];
                int nc = c + dc[d];
                if (A[nr][nc] != '#') {
                    r = nr;
                    c = nc;
                }
            }
        } else if (com == 'L') {
            if (A[r][c] == 'R') {
                d += 1;
            } else {
                d -= rep;
            }
        } else {
            if (A[r][c] == 'L') {
                d -= 1;
            } else {
                d += rep;
            }
        }
        if (d > 3) d -= 4;
        if (d < 0) d += 4;
    }
    return r * M + c;
}

void input() {
    readln;
    foreach (i; 0..N) {
        S[i] = readln.chomp;
    }
}

void init() {
    foreach (i; 0..M) {
        foreach (j; 0..M) {
            if (i == 0 || j == 0 || i == M-1 || j == M-1) {
                A[i][j] = '#';
            } else {
                A[i][j] = init_masu[uniform(0, init_masu.length)];
            }
        }
    }
}

void output() {
    debug{return;}
    //foreach (a; A) write(a), write("\r\n");
    foreach (a; A) writef(a), writef("\r\n");
}

import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;
import std.datetime;
 
 
immutable int N = 50;
auto board = new char[N][N];
auto stack = new int[N*N];
auto used = new bool[N][N];
int[4] dx = [0, 0, 1, -1];
int[4] dy = [1, -1, 0, 0];
char[3] stones = ['.', '+', '-'];
 
int eval() {
    int p;
    auto new_board = new char[][](N, N);
    foreach (i; 0..N) {
        p = 0;
        foreach (j; 0..N) {
            if (board[i][j] == '.')
                continue;
            else if (board[i][j] == '-')
                p = j + 1;
            else {
                new_board[i][p] = board[i][j];
                p += 1;
            }
        }
    }
 
 
    int maru, batu, score, ptr, r, c, nr, nc;
    char marubatu;
    foreach (i; 0..N) foreach (j; 0..N) used[i][j] = false;
 
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            if (used[i][j])
                continue;
            if (new_board[i][j] != 'o' && new_board[i][j] != 'x')
                continue;
            marubatu = new_board[i][j];
            score = 0;
            ptr = 0;
            stack[0] = i * N + j;
            while (ptr >= 0) {
                r = stack[ptr] / N;
                c = stack[ptr] % N;
                ptr -= 1;
                if (used[r][c])
                    continue;
                score += 1;
                used[r][c] = true;
                foreach (k; 0..4) {
                    nr = r + dx[k];
                    nc = c + dy[k];
                    if (nr < 0 || nr >= N || nc < 0 || nc >= N)
                        continue;
                    if (new_board[nr][nc] != marubatu)
                        continue;
                    if (used[nr][nc])
                        continue;
                    ptr += 1;
                    stack[ptr] = nr * N + nc;
                }
            }
            if (marubatu == 'o') maru = max(maru, score);
            else if (marubatu == 'x') batu = max(batu, score);
            else assert(false);
        }
    }
 
    return maru + batu;
}
 
 
void dump() {
    auto s = new char[](N);
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            s[N-j-1] = board[N-j-1][N-i-1];
        }
        writeln(s.to!string);
    }
}
 
 
void main() {
    auto stattime = Clock.currTime();
 
    foreach (i; 0..N) {
        auto s = readln.chomp;
        foreach (j; 0..N) {
            board[j][N-i-1] = s[j].to!char;
        }
    }
 
    int score, i, rand;
    char[N] orig;
    int best_score = eval;
 
    while ((Clock.currTime - stattime).total!"msecs" < dur!"msecs"(9950).total!"msecs") {
        i = uniform(0, N);
        orig = board[i];
        foreach (j; 0..N) {
            if (board[i][j] == '.' || board[i][j] == '+' || board[i][j] == '-') {
                rand = uniform(0, 100);
                if (rand < 82) board[i][j] = '.';
                else if (rand < 97) board[i][j] = '+';
                else board[i][j] = '-';
            }
        }
            
        score = eval;
        if (score >= best_score) {
            best_score = score;
        }
        else {
            board[i] = orig;
        }
 
    }
 
 
    
    dump;
    eval.writeln;
}

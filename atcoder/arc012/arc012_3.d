import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;
 
 
bool solve() {
    auto N = 19;
    auto B = N.iota.map!(_ => readln.chomp.array).array;
 
    int no, nx;
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            if (B[i][j] == 'o') no += 1;
            if (B[i][j] == 'x') nx += 1;
        }
    }
 
    if (no - nx != 0 && no - nx != 1)
        return false;
 
    auto series = new int[][](2, 30);
    int[4] dr = [0, 1, 1, 1];
    int[4] dc = [1, 1, 0, -1];
    bool o_win, x_win;
    foreach (d; 0..4) {
        auto used = new bool[][](N, N);
        foreach (i; 0..N){
            foreach (j; 0..N) {
                if (B[i][j] == '.' || used[i][j]) continue;
                auto ox = B[i][j];
                auto ni = i;
                auto nj = j;
                auto cnt = 0;
                while (ni >= 0 && ni < N && nj >= 0 && nj < N && B[ni][nj] == ox) {
                    used[ni][nj] = true;
                    ni += dr[d];
                    nj += dc[d];
                    cnt += 1;
                }
                if (ox == 'o') {
                    if (cnt >= 5) o_win = true;
                    if (cnt > 9) return false;
                    series[0][cnt] += 1;
                }
                if (ox == 'x') {
                    if (cnt >= 5) x_win = true;
                    if (cnt > 9) return false;
                    series[1][cnt] += 1;
                }
            }
        }
    }
 
    if (o_win && x_win) return false;
    if (o_win && no - nx == 0) return false;
    if (x_win && no - nx == 1) return false;
 
    int cntt;
    foreach (i; 5..30) cntt += series[0][i];
    foreach (i; 5..30) cntt += series[1][i];
    if (cntt <= 1) return true;
    
    foreach (x; 0..N) {
        foreach (y; 0..N) {
            if (B[x][y] == '.') continue;
            auto prev = B[x][y];
            B[x][y] = '.';
            bool flag = true;
            foreach (d; 0..4) {
                auto used = new bool[][](N, N);
                foreach (i; 0..N){
                    foreach (j; 0..N) {
                        if (B[i][j] == '.' || used[i][j]) continue;
                        auto ox = B[i][j];
                        auto ni = i;
                        auto nj = j;
                        auto cnt = 0;
                        while (ni >= 0 && ni < N && nj >= 0 && nj < N && B[ni][nj] == ox) {
                            used[ni][nj] = true;
                            ni += dr[d];
                            nj += dc[d];
                            cnt += 1;
                        }
                        if (cnt >= 5) flag = false;
                    }
                }
            }
            if (flag) return true;
            B[x][y] = prev;
        }
    }
 
    
    return false;
}
        
void main() {
 
    writeln(solve ? "YES" : "NO");
}

import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    auto B = readln.split.map!(to!long).array;

    bool[][] solve(const long[] A) {
        auto M = new bool[][](N, 60);
        foreach (i; 0..N) {
            long a = A[i];
            foreach (j; 0..60) {
                M[i][j] = (a & 1);
                a >>= 1;
            }
        }

        int cnt = 0;
        foreach (j; 0..60) {
            foreach (i; cnt..N) {
                if (M[i][j]) {
                    swap(M[cnt], M[i]);
                    foreach (k; 0..N) {
                        if (k != cnt && M[k][j]) {
                            foreach (l; 0..60) {
                                M[k][l] ^= M[cnt][l];
                            }
                        }
                    }
                    cnt += 1;
                    break;
                }
            }
        }

        //M.each!(m => m.map!(x => x ? 1 : 0).writeln);
        //writeln;
        return M;
    }

    writeln(solve(A) == solve(B) ? "Yes" : "No");
}

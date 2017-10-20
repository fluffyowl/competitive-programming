import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;
     
     
void main() {
    auto A = readln.chomp.map!(x => x == '1').array;
    auto B = readln.chomp.map!(x => x == '1').array;
    auto N = A.length.to!int;
     
    if (A.any && !B.any) {
        writeln(-1);
        return;
    }
     
    auto L = new int[](N);
    auto R = new int[](N);
     
    foreach (i; 0..N) {
        foreach (j; 0..N) {
            if (B[((i-j)%N+N)%N]) {
                L[i] = j;
                break;
            }
        }
        foreach (j; 0..N) {
            if (B[(i+j)%N]) {
                R[i] = j;
                break;
            }
        }
    }

     
    int ans = 1 << 29;
     
    foreach (i; 0..N) { // A[i]を先頭にする
        int flip = 0;
        auto LR = new Tuple!(int, int)[](N);
     
        foreach (j; 0..N) {
            int k = (i + j) % N;
            if (B[j] != A[k]) {
                flip++;
                LR[j] = tuple(L[k], R[k]);
            } else {
                LR[j] = tuple(0, 0);
            }
        }

        // 左 -> 右
        LR.sort!"a[0] < b[0]";
     
        auto r_max = new int[](N + 1);
        r_max[N] = 0;
     
        for (int j = N - 1; j >= 0; j--) {
            r_max[j] = max(LR[j][1], r_max[j+1]);
        }

        foreach (j; 0..N) {
            int left = LR[j][0];
            int right = r_max[j+1] + left;
            int pos = i - left + right;
            pos = (pos % N + N) % N;
            pos = min(pos, N - pos);
            ans = min(ans, left + right + pos + flip);
            debug {writeln([i, j, left, right, pos]);}
        }


        // 右 -> 左
        LR.sort!"a[1] < b[1]";
     
        auto l_max = new int[](N + 1);
        l_max[N] = 0;
     
        for (int j = N - 1; j >= 0; j--) {
            l_max[j] = max(LR[j][0], l_max[j+1]);
        }

        foreach (j; 0..N) {
            int right = LR[j][1];
            int left = l_max[j+1] + right;
            int pos = i - left + right;
            pos = (pos % N + N) % N;
            pos = min(pos, N - pos);
            ans = min(ans, left + right + pos + flip);
            debug {writeln([i, j, left, right, pos]);}
        }        
    }
     
    ans.writeln;
}

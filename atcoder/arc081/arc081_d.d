import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto A = H.iota.map!(_ => readln.chomp).array;
    auto B = new int[][](H, W);
    auto C = new int[][](H, W-1);
    foreach (i; 0..H) foreach (j; 0..W-1) C[i][j] = A[i][j] == A[i][j+1];

    fill(B[H-1], 1); B[H-1][W-1] = 0;
    for (int j = 0; j < W - 1; j++) {
        for (int i = H - 2; i >= 0; i--) {
            if (C[i+1][j] == C[i][j]) B[i][j] = B[i+1][j] + 1;
            else B[i][j] = 1;
        }
    }

    
    int ans = max(H, W);
    
    foreach (i; 0..H) {
        DList!(Tuple!(int, int)) stack;
        foreach (j; 0..W) {
            if (stack.empty || stack.back[1] < B[i][j]) {
                stack.insertBack(tuple(j, B[i][j]));
            } else {
                int pos = j;
                while (!stack.empty && stack.back[1] > B[i][j]) {
                    int area = (j - stack.back[0] + 1) * stack.back[1];
                    ans = max(ans, area);
                    pos = stack.back[0];
                    stack.removeBack;
                }
                stack.insertBack(tuple(pos, B[i][j]));
            }
        }
    }

    ans.writeln;
}

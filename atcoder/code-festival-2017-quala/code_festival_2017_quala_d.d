import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;
     
void main() {
    auto s = readln.split.map!(to!int);
    auto H = s[0];
    auto W = s[1];
    auto D = s[2];
     
    auto N = max(H, W) * 3;
    auto B = new int[][](N, N);
    int[] colors = [1, 2, 3, 4];
     
    for (int i = 0; i * D < N; ++i)
        for (int j = 0; j * D < N; ++j)
            for (int a = 0; a < D; a++)
                for (int b = 0; b < D; b++)
                    if (i * D + a < N && j * D + b < N)
                        B[i*D+a][j*D+b] = colors[i%2*2+j%2];
     
        
    auto ans = new int[][](H, W);
    auto color = " RYGB";
        
    foreach (i; 0..H) {
        foreach (j; 0..W) {
            int ni = i + j;
            int nj = i - j + W;
            ans[i][j] = B[ni][nj];
        }
    }
     
    ans.each!(an => an.map!(a => color[a]).writeln);
}

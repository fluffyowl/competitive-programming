import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;

int dist2(int x1, int y1, int x2, int y2) {
    return (x1 - x2) ^^ 2 + (y1 - y2) ^^ 2;
}

int solve(int N, int K) {
    int cx = N / 2;
    int cy = N / 2;
    int radius = (N / 2) ^^ 2;
    int ans = 0;

    for (int x = 0; x < N; x += K) {
        for (int y = 0; y < N; y += K) {
            bool ok = true;
            if (dist2(x, y, cx, cy) > radius) ok = false;
            if (dist2(x+K, y, cx, cy) > radius) ok = false;
            if (dist2(x, y+K, cx, cy) > radius) ok = false;
            if (dist2(x+K, y+K, cx, cy) > radius) ok = false;
            ans += ok;
        }
    }

    return ans;
}

void main() {
    auto K = readln.chomp.to!int;
    writeln(solve(200, K), " ", solve(300, K));
}

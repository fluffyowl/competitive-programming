import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto s = readln.split.map!(to!long);
    auto H = s[0];
    auto W = s[1];

    if (H % 3 == 0 || W % 3 == 0) {
        writeln(0);
        return;
    }

    long ans = min(H, W);

    foreach (i; 1..W) {
        long area1 = H * i;
        long area2 = H / 2 * (W - i);
        long area3 = (H / 2 + H % 2) * (W - i);
        long tmp = max(max(abs(area1 - area2), abs(area2 - area3)), abs(area3 - area1));
        ans = min(ans, tmp);
    }
    foreach (i; 1..H) {
        long area1 = W * i;
        long area2 = W / 2 * (H - i);
        long area3 = (W / 2 + W % 2) * (H - i);
        long tmp = max(max(abs(area1 - area2), abs(area2 - area3)), abs(area3 - area1));
        ans = min(ans, tmp);
    }

    ans.writeln;
}

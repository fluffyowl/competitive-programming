import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    int R, G, B;
    scanf("%d %d %d", &R, &G, &B);

    int ans = int.max;

    for (int g = -300; g <= 300; g++) {
        int tmp = 0;

        int r = min(g-R, -100-(R-1)/2);
        int b = max(g+G, 100-(B-1)/2);
        int rl = max(0, -r-100);
        int rr = max(0, r+R+100-1);
        int gl = max(0, -g);
        int gr = max(0, g+G-1);
        int bl = max(0, 100-b);
        int br = max(0, b+B-100-1);
        tmp += rl * (rl + 1) / 2 + rr * (rr + 1) / 2;
        tmp += gl * (gl + 1) / 2 + gr * (gr + 1) / 2;
        tmp += bl * (bl + 1) / 2 + br * (br + 1) / 2;
        if (rl > R) tmp -= (rl-R) * (rl-R+1) / 2;
        if (rr > R) tmp -= (rr-R) * (rr-R+1) / 2;
        if (gl > G) tmp -= (gl-G) * (gl-G+1) / 2;
        if (gr > G) tmp -= (gr-G) * (gr-G+1) / 2;
        if (bl > B) tmp -= (bl-B) * (bl-B+1) / 2;
        if (br > B) tmp -= (br-B) * (br-B+1) / 2;
        ans = min(ans, tmp);

    }

    ans.writeln;
}

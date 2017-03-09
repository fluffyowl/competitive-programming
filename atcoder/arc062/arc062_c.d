import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

alias Tuple!(int, "c1", int, "c2", int, "c3", int, "c4") Die;


Die normalize_die(int a, int b, int c, int d) {
    auto t1 = Die(a, b, c, d);
    auto t2 = Die(b, c, d, a);
    auto t3 = Die(c, d, a, b);
    auto t4 = Die(d, a, b, c);
    auto t5 = [t1, t2, t3, t4];
    t5.sort();
    return t5[0];
}

void main() {
    auto N = readln.chomp.to!int;
    long[Die] mem;
    auto dice = new Die[](N);

    foreach (i; 0..N) {
        auto s = readln.split.map!(to!int);
        auto d = normalize_die(s[0], s[1], s[2], s[3]);
        if (d in mem) mem[d] += 1;
        else mem[d] = 1;
        dice[i] = d;
    }

    long ans = 0;
    foreach (i; 0..N) {
        auto d1 = [dice[i].c1, dice[i].c2, dice[i].c3, dice[i].c4];
        foreach (j; i+1..N) {
            int c5 = dice[j][0];
            int c6 = dice[j][1];
            int c7 = dice[j][2];
            int c8 = dice[j][3];
            foreach (k; 0..4) {
                int c1 = d1[k];
                int c2 = d1[(k+1)%4];
                int c3 = d1[(k+2)%4];
                int c4 = d1[(k+3)%4];
                auto d = new Die[](4);
                d[0] = normalize_die(c8, c1, c4, c5);
                d[1] = normalize_die(c2, c7, c6, c3);
                d[2] = normalize_die(c8, c7, c2, c1);
                d[3] = normalize_die(c4, c3, c6, c5);
                auto a = new long[](4);
                bool no_such_die = false;
                foreach (l; 0..4) {
                    if (!(d[l] in mem)) {
                        no_such_die = true;
                        break;
                    }
                    a[l] = mem[d[l]];
                    if (d[l] == dice[i]) a[l] -= 1;
                    if (d[l] == dice[j]) a[l] -= 1;
                }

                if (no_such_die)
                    continue;
                //d.each!(writeln);
                //a.writeln;

                foreach (l; 0..4) {
                    foreach (m; l+1..4) {
                        if (d[l] == d[m]) a[m] -= 1;
                    }
                }
                //a.writeln;

                foreach (l; 0..4) {
                    if (d[l].c1 == d[l].c2 && d[l].c2 == d[l].c3 && d[l].c3 == d[l].c4)
                        a[l] *= 4;
                    else if (d[l].c1 == d[l].c3 && d[l].c2 == d[l].c4)
                        a[l] *= 2;
                    a[l] = max(0, a[l]);
                }

                ans += a[0] * a[1] * a[2] * a[3];
            }
        }
    }

    writeln(ans/3);
}

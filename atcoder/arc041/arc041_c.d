import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;

alias Tuple!(long, "x", char, "d") Rabbit;
alias Tuple!(long, "r", long, "rn", long, "l", long, "ln") Seg;

void main() {
    int N;
    long L;
    scanf("%d %lld", &N, &L);

    auto rabbits = new Rabbit[](N);

    foreach (i; 0..N) {
        long x;
        char d;
        scanf("%lld %c", &x, &d);
        rabbits[i] = Rabbit(x, d);
    }
    if (rabbits[0].d == 'L') {
        rabbits = Rabbit(0, 'R') ~ rabbits;
        N += 1;
    }
    if (rabbits[$-1].d == 'R') {
        rabbits ~= Rabbit(L+1, 'L');
        N += 1;
    }


    auto seg = Seg(-1, 0, -1, 0);
    long ans = 0;
    
    foreach (i; 0..N) {
        if (rabbits[i].d == 'R' && seg.l == -1) {
            if (seg.rn > 0) {
                long interval = rabbits[i].x - seg.r - 1;
                ans += interval * seg.rn;
            }
            seg.r = rabbits[i].x;
            seg.rn += 1;
        }
        else if (rabbits[i].d == 'R' && seg.l >= 0) {
            long interval = seg.l - seg.r - 1;
            ans += interval * max(seg.rn, seg.ln);
            seg = Seg(rabbits[i].x, 1, -1, 0);
        }
        else if (rabbits[i].d == 'L') {
            if (seg.ln > 0) {
                long interval = rabbits[i].x - seg.l - seg.ln;
                ans += interval;
            }
            else {
                seg.l = rabbits[i].x;
            }
            seg.ln += 1;
        }
        
    }

    long interval = seg.l - seg.r - 1;
    ans += interval * max(seg.rn, seg.ln);

    writeln(ans);
}

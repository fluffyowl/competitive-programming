import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
    immutable real EPS = 0.000000001;

    int N;
    scanf("%d", &N);
    auto X = new long[](N);
    auto Y = new long[](N);
    foreach (i; 0..N)
        scanf("%lld %lld", &X[i], &Y[i]);


    long ans_right = 0;
    long ans_obtuse = 0;

    foreach (i; 0..N) {
        real[] args;
        foreach (j; 0..N) {
            if (i == j)
                continue;
            args ~= atan2((X[j]-X[i]).to!real, (Y[j]-Y[i]).to!real);
            if (args[$-1] < 0)
                args[$-1] = 2 * PI + args[$-1];
            args ~= args[$-1] + 2 * PI;
        }
        args.sort();
        //args.writeln;

        foreach (j; 0..N-1) {
            int hi = j + N - 2;
            int lo = j;
            while (hi - lo > 1) {
                int mid = (hi + lo) / 2;
                if (args[mid] - args[j] > PI_2 - EPS)
                    hi = mid;
                else
                    lo = mid;
            }
            while (hi < j + N - 1 && abs(args[hi] - args[j] - PI_2) < EPS) {
                hi += 1;
                ans_right += 1;
            }

            int hi2 = j + N - 1;
            int lo2 = j;
            while (hi2 - lo2 > 1) {
                int mid = (hi2 + lo2) / 2;
                if (args[mid] - args[j] < PI + EPS)
                    lo2 = mid;
                else
                    hi2 = mid;
            }

            //writeln(args[j+1..j+N-1].map!(x => x - args[j]));
            //writeln(args[hi2] - args[j], " ", args[lo2] - args[j]);
            //writeln(j, " ", hi2, " ", lo2, " ", hi);
            if (hi < j + N - 1 && args[hi] - args[j] > PI_2 - EPS)
                ans_obtuse += lo2 - hi + 1;
            //writeln(lo2 - hi + 1);
            //writeln("ans_ob ", ans_obtuse);
        }
    }

    long M = N.to!long;
    writeln(M * (M-1) * (M-2) / 6 - ans_right - ans_obtuse, " ",
            ans_right, " ",
            ans_obtuse);
}

import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    immutable long INF = 1L << 59;
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    

    Tuple!(long, int[]) solve(long[] X) {
        int n = X.length.to!int;
        int[] ans;
        long val;

        if (X.map!(x => x <= 0).all) {
            long maxv = -INF;
            int maxi = -1;
            for (int i = 0; i < X.length.to!int; i += 2) {
                if (X[i] > maxv) maxv = X[i], maxi = i;
            }
            foreach_reverse (i; maxi+1..X.length.to!int) ans ~= i+1;
            foreach (i; 0..maxi) ans ~= 1;
            return tuple(maxv, ans);
        }
        
        for (int i = n - 1; i > 0; i -= 2) {
            if (X[i] > 0) break;
            ans ~= [i+1, i];
            X.popBack;
            X.popBack;
            n -= 2;
        }

        for (int i = 0; i < n - 1; ) {
            if (X[i] > 0) break;
            ans ~= [1, 1];
            X.popFront;
            X.popFront;
            n -= 2;
        }

        while (X.length > 1) {
            if (X[2] > 0) {
                X[0] += X[2];
                X = X.remove(1);
                X = X.remove(1);
                ans ~= 2;
            } else {
                X = X.remove(1);
                X = X.remove(1);
                ans ~= 3;
             }
        }

        return tuple(X[0], ans);
    }


    auto B = A.dup;
    auto C = A.dup;
    int[] ansB, ansC;

    if (N % 2 == 0) {
        B.popBack;
        C.popFront;
        ansB ~= N;
        ansC ~= 1;
    } else {
        C.popFront;
        C.popBack;
        ansC ~= N;
        ansC ~= 1;
    }

    auto retB = solve(B);
    auto retC = solve(C);
    auto ans = retB >= retC ? retB : retC;
    if (retB >= retC) ans[1] = ansB ~ ans[1];
    else  ans[1] = ansC ~ ans[1];

    ans[0].writeln;
    ans[1].length.writeln;
    ans[1].each!writeln;
}

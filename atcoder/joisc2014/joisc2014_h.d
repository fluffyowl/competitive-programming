import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    int[long][3] mx;
    int[long][3] mn;

    mx[0][0] = 0;
    mn[0][0] = 0;

    long JOI = 0;
    int J, O, I;
    foreach (i; 0..N) {
        if (S[i] == 'J') {
            if (J == 0 && O > 0 && I > 0)
                O -= 1, I -= 1;
            else
                J += 1;
        } else if (S[i] == 'O') {
            if (O == 0 && J > 0 && I > 0)
                J -= 1, I -= 1;
            else
                O += 1;
        } else if (S[i] == 'I') {
            if (I == 0 && J > 0 && O > 0)
                J -= 1, O -= 1;
            else
                I += 1;
        }
        JOI = J * 200000L^^2 + O * 200000 + I;
        mx[(i+1)%3][JOI] = i+1;
        if (!(JOI in mn[(i+1)%3])) mn[(i+1)%3][JOI] = i+1;
    }

    int ans = 0;

    foreach (x; 0..3) {
        foreach (k; mn[x].keys) {
            ans = max(ans, mx[x][k] - mn[x][k]);
        }
    }

    ans.writeln;
} import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    int[long][3] mx;
    int[long][3] mn;

    mx[0][0] = 0;
    mn[0][0] = 0;

    long JOI = 0;
    int J, O, I;
    foreach (i; 0..N) {
        if (S[i] == 'J') {
            if (J == 0 && O > 0 && I > 0)
                O -= 1, I -= 1;
            else
                J += 1;
        } else if (S[i] == 'O') {
            if (O == 0 && J > 0 && I > 0)
                J -= 1, I -= 1;
            else
                O += 1;
        } else if (S[i] == 'I') {
            if (I == 0 && J > 0 && O > 0)
                J -= 1, O -= 1;
            else
                I += 1;
        }
        JOI = J * 200000L^^2 + O * 200000 + I;
        mx[(i+1)%3][JOI] = i+1;
        if (!(JOI in mn[(i+1)%3])) mn[(i+1)%3][JOI] = i+1;
    }

    int ans = 0;

    foreach (x; 0..3) {
        foreach (k; mn[x].keys) {
            ans = max(ans, mx[x][k] - mn[x][k]);
        }
    }

    ans.writeln;
}

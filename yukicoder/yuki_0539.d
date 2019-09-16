import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;

bool is_num(dchar x) {
    return '0' <= x && x <= '9';
}

bool is_ten(dchar x) {
    return x - '0' == 10;
}

void solve() {
    auto S = ('a' ~ readln.chomp).to!(dchar[]);

    int status = 0;
    int carry = 0;

    dchar increment(dchar x) {
        if ((x + 1).is_ten) {
            carry = 1;
            return '0';
        } else {
            carry = 0;
            return x + 1;
        }
    }

    foreach_reverse (i; 0..S.length.to!int) {
        if (status == 0 && S[i].is_num) {
            status = 1;
            S[i] = increment(S[i]);
        } else if (status == 1 && S[i].is_num) {
            if (carry) {
                S[i] = increment(S[i]);
            }
        } else if (status == 1 && !S[i].is_num) {
            if (carry) {
                S = S[0..i+1] ~ '1' ~ S[i+1..$];
            }
            break;
        }
    }

    S[1..$].writeln;
}

void main(){
    auto T = readln.chomp.to!int;
    while (T--) solve;
}

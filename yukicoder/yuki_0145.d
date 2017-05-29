import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;


void main() {
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    auto C = new int[](500);
    foreach (i; 0..N) C[S[i]] += 1;


    // Z
    int ans = C['z'];

    // Y[VWX]
    int bet = 0;
    for (char c = 'v'; c <= 'x'; c++) bet += C[c];
    bet = min(C['y'], bet);
    ans += bet;
    C['y'] -= bet;
    
    // YU[LMNOPQRST]
    bet = 0;
    for (char c = 'l'; c <= 't'; c++) bet += C[c];
    bet = [C['y'], C['u'], bet].reduce!min;
    ans += bet;
    C['y'] -= bet;
    C['u'] -= bet;

    // YUKJ
    bet = [C['y'], C['u'], C['k'], C['j']].reduce!min;
    ans += bet;
    C['y'] -= bet;
    C['u'] -= bet;
    C['k'] -= bet;

    // YUKI[A-H]
    bet = 0;
    for (char c = 'a'; c <= 'h'; c++) bet += C[c];
    bet = [C['y'], C['u'], C['k'], C['i'], bet].reduce!min;
    ans += bet;
    C['y'] -= bet;
    C['u'] -= bet;
    C['k'] -= bet;
    C['i'] -= bet;

    // YUKII
    bet = [C['y'], C['u'], C['k'], C['i'] / 2].reduce!min;
    ans += bet;
    C['y'] -= bet;
    C['u'] -= bet;
    C['k'] -= bet;

    // YUKK
    bet = [C['y'], C['u'], C['k'] / 2].reduce!min;
    ans += bet;
    C['y'] -= bet;
    C['u'] -= bet;
    
    // YUU
    bet = [C['y'], C['u'] / 2].reduce!min;
    ans += bet;
    C['y'] -= bet;
    
    // YY
    ans += C['y'] / 2;

    ans.writeln;
}


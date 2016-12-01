import std.stdio;
import std.array;
import std.string;
import std.conv;
import std.algorithm;
import std.typecons;
import std.range;
import std.random;
import std.math;
import std.container;
import std.numeric;
import std.bigint;


void main() {
  auto input = readln.split.map!(to!int);
  auto N = input[0];
  auto M = input[1];
  auto X = readln.split.map!(to!int).array;
  auto cnt = new int[][](M);
  foreach (x; X) cnt[x%M] ~= x;
  auto amari = new int[](10^^5+1);

  int ans = 0;
  foreach (m; 0..M/2+1) {
    int minm, mm;
    if (m == 0 || (m == M/2 && M % 2 == 0)) {
      ans += cnt[m].length/2;
    }
    else {
      minm = min(cnt[m].length, cnt[M-m].length).to!int;
      mm = cnt[m].length > cnt[M-m].length ? m : M-m;
      int[int] same;
      foreach (x; cnt[mm]) {
        if (x in same) same[x] += 1;
        else same[x] = 1;
      }
      ans += minm + min((cnt[mm].length-minm)/2, same.values.map!(x => x/2).sum);
    }
  }

  writeln(ans);
}

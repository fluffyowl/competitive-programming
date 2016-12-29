import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void main() {
  auto N = readln.chomp.to!int;
  auto A = N.iota.map!(_ => readln.chomp.to!int).array;
  int[5] cnt;
  foreach(a; A) cnt[a]++;
  int ans;

  ans += cnt[4];

  auto x = min(cnt[1], cnt[3]);
  ans += x;
  cnt[3] -= x;
  cnt[1] -= x;

  ans += cnt[3];
  cnt[3] = 0;

  ans += cnt[2]/2;
  ans += cnt[1]/4;
  cnt[2] %= 2;
  cnt[1] %= 4;

  if (cnt[2] > 0) {
    ans += 1;
    cnt[2] = 0;
    cnt[1] = max(0, cnt[1]-2);
  }

  writeln(ans+(cnt[1]>0));
}

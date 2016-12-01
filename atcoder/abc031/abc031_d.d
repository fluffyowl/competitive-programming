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
import core.bitop;



void main() {
  auto input = readln.split;
  auto K = input[0].to!int;
  auto N = input[1].to!int;
  auto VW = iota(N).map!(_ => readln.split.array).array;

  foreach (i; 0..3^^K) {
    auto cnt = new int[](K);
    foreach (j; 0..K)
      cnt[j] = 3 - i/(3^^j)%3;
    auto assign = new string[](K);
    bool flag = true;
    foreach (j; 0..N) {
      auto v = VW[j][0];
      auto w = VW[j][1];
      if (v.map!(c => cnt[c-'1']).sum != w.length) {
        flag = false;
        break;
      }
      int k = 0;
      foreach (c; v) {
        auto n = c-'1';
        auto s = w[k..k+cnt[n]];
        if (assign[n].length > 0 && assign[n] != s) {
          flag = false;
          break;
        }
        assign[n] = s;
        k += cnt[n];
      }
      if (!flag)
        break;
    }
    if (flag) {
      foreach (a; assign)
        writeln(a);
      break;
    }
  }
}

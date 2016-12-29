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
  auto s = readln.split.map!(to!int);
  auto H = s[0];
  auto W = s[1];
  auto A = H.iota.map!(_ => readln.split.map!(to!int).array).array;
  auto B = new int[](H+1);
  foreach (i; 0..H) {
    int b = 0;
    foreach (j; 0..W)
      if (A[i][j] == 1)
        b |= (1 << j);
    B[i] = b;
  }

  auto p = new int[](1<<W);
  foreach (i; 0..(1<<W))
    p[i] = 2^^30-1;
  foreach (on; 0..(1<<W)) {
    foreach (push; 0..(1<<W)) {
      auto tmp = on;
      foreach (i; 0..W)
        if (push & (1 << i))
          tmp ^= (((0b111 << i) >> 1) & ((1 << W) - 1));
      if (tmp == 0 && p[on].popcnt > push.popcnt)
        p[on] = push;
    }
  }

  int ans = int.max;
  foreach (top; 0..(1<<W)) {
    auto tmp_b = B.dup;
    int tmp_ans = top.popcnt;

    foreach (i; 0..W) {
      if (top & (1 << i)) {
        tmp_b[0] ^= (((0b111 << i) >> 1) & ((1 << W) -1));
        tmp_b[1] ^= (((0b111 << i) >> 1) & ((1 << W) -1));
      }
    }

    foreach (i; 1..H) {
      if (p[tmp_b[i-1]] == 2^^30-1) {
        tmp_ans = int.max;
        break;
      }
      tmp_ans += p[tmp_b[i-1]].popcnt;
      foreach (j; 0..W)
        if (p[tmp_b[i-1]] & (1 << j)) {
          tmp_b[i] ^= (((0b111 << j) >> 1) & ((1 << W) -1));
          tmp_b[i+1] ^= (((0b111 << j) >> 1) & ((1 << W) -1));
        }
    }
    if (tmp_b[H-1] != 0) tmp_ans = int.max;
    ans = min(ans, tmp_ans);
  }

  (ans == int.max ? "Impossible" : ans.to!string).writeln;
}


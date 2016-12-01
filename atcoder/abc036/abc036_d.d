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


long mod = 10L^^9+7;
int N;
int[][] adj;
long[][] mem;

long rec(int n, int prev, bool prev_black) {
  if (mem[n][prev_black] != 0)
    return mem[n][prev_black];

  long ret_w = 1;
  foreach (nn; adj[n]) {
    if (nn == prev) continue;
    (ret_w *= rec(nn, n, false)) %= mod;
  }
  long ret_b = 0;
  if (!prev_black) {
    ret_b = 1;
    foreach (nn; adj[n]) {
      if (nn == prev) continue;
      (ret_b *= rec(nn, n, true)) %= mod;
    }
  }
  return (mem[n][prev_black] = (ret_w+ret_b) % mod);
}


void main() {
  N = readln.chomp.to!int;
  adj = new int[][](N);
  foreach (_; 0..N-1) {
    auto input = readln.split.map!(to!int);
    adj[input[0]-1] ~= input[1]-1;
    adj[input[1]-1] ~= input[0]-1;
  }
  mem = new long[][](N, 2);
  writeln(rec(0, -1, 0));
}

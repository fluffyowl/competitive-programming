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
import core.bitop;


int N;
int[][] adj;
int[] ans;

int dfs(int n) {
  int s = 0;
  foreach (m; adj[n]) {
    auto d = dfs(m);
    ans[n] = max(ans[n], d);
    s += d;
  }
  ans[n] = max(ans[n], N-1-s);
  return s + 1;
}

void main() {
  N = readln.chomp.to!int;
  adj = new int[][](N);
  foreach (i; 1..N)
    adj[readln.chomp.to!int] ~= i;
  ans = new int[](N);
  dfs(0);
  foreach (a; ans)
    a.writeln;
}

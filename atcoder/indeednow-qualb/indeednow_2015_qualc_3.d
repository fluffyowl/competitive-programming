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


void main() {
  auto N = readln.chomp.to!int;
  auto adj = new int[][](N+1);
  foreach (_; 0..N-1) {
    auto s = readln.split.map!(to!int);
    adj[s[0]] ~= s[1];
    adj[s[1]] ~= s[0];
  }

  int[] ans;
  auto q = BinaryHeap!(Array!int, "a > b")();
  auto used = new bool[](N+1);
  q.insert(1);
  while (!q.empty) {
    auto n = q.front;
    q.removeFront;
    if (used[n])
      continue;
    used[n] = true;
    ans ~= n;
    foreach (m; adj[n])
      if (!used[m])
        q.insert(m);
  }

  ans.map!(a => a.to!string).join(" ").writeln;
}

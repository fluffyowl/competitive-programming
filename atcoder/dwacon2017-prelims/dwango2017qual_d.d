import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint;


void main() {
  auto s = readln.split.map!(to!int);
  auto N = s[0];
  auto M = s[1];
  auto X = new int[](N);
  auto Y = new int[](N);
  foreach (i; 0..N) {
    s = readln.split.map!(to!int);
    X[i] = s[0];
    Y[i] = s[1];
  }

  auto queue = new BinaryHeap!(Array!int, "a > b")();
  int ans;
  int tmp_ans;
  foreach (i; 0..N) {
    if (i < M) {
      queue.insert(X[i]-Y[i]);
      tmp_ans += X[i];
      ans += X[i];
      continue;
    }
    auto ss = queue.front;
    queue.popFront;
    queue.insert(X[i]-Y[i]);
    tmp_ans += X[i];
    tmp_ans -= ss;
    ans = max(ans, tmp_ans);
  }

  ans.writeln;
}

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

void main() {
  auto input = readln.split.map!(to!long);
  auto N = input[0];
  auto D = input[1];
  auto T = input[2];
  auto X = readln.split.map!(to!long);

  long[][long] M;
  long ans = N;

  foreach (x; X) {
    auto d = x%D >= 0 ? x%D : D+x%D;
    if (d in M)
      M[d] ~= x;
    else
      M[d] = [x];
  }

  foreach (key; M.keys) {
    auto m = M[key].sort();
    long p_ans = 2*T;
    foreach (i; 0..m.length-1) {
      auto interval = (m[i+1] - m[i]) / D - 1;
      p_ans += min(interval, 2*T);
    }
    ans += p_ans;
  }

  writeln(ans);
  
}

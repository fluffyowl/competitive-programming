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
  auto input = readln.split.map!(to!long);
  auto R = input[0];
  auto C = input[1];
  auto K = input[2];
  auto N = readln.chomp.to!long;
  auto ame = new Tuple!(long, long)[](N);
  auto row = new long[](R);
  auto col = new long[](C);
  foreach (i; 0..N) {
    input = readln.split.map!(to!long);
    auto r = input[0]-1;
    auto c = input[1]-1;
    ame[i] = tuple(r, c);
    row[r] += 1;
    col[c] += 1;
  }

  auto row_cnt = new long[](C+1);
  auto col_cnt = new long[](R+1);
  foreach (i; 0..R) row_cnt[row[i]] += 1;
  foreach (i; 0..C) col_cnt[col[i]] += 1;

  long ans = 0;
  foreach (i; 0..C+1) {
    auto j = K - i;
    if (j >= 0 && j <= R)
      ans += row_cnt[i]*col_cnt[j];
  }

  foreach (a; ame) {
    auto i = a[0], j = a[1];
    if (row[i] + col[j] == K)
      ans -= 1;
    else if (row[i] + col[j] == K+1)
      ans += 1;
  }

  writeln(ans);
}

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
  auto S = readln.chomp;
  auto N = S.length.to!int;

  auto LR = new int[][](N);
  auto P3_left = new int[](N);
  int left, right;
  foreach (d; 0..2)
    foreach (i; 0..N) {
      left = i;
      right = i+d;
      while (left >= 0 && right < N && S[left] == S[right]) {
        LR[left] ~= right;
        if (right == N-1)
          P3_left[left] = 1;
        left--;
        right++;
      }
    }

  auto acm = new long[](N+1);
  foreach (i; 0..N)
    acm[i+1] = acm[i] + P3_left[i];

  long ans = 0;
  foreach (r1; LR[0]) {
    if (r1 >= N-3)
      continue;
    foreach (r2; LR[r1+1]) {
      if (r2 >= N-2)
        continue;
      ans += acm[N] - acm[r2+2];
    }
  }
  ans.writeln;
}


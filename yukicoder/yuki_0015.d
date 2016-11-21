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

alias Tuple!(int, "p", int, "b") comb;

int binarySearch(int n, ref comb[] c) {
  int high = c.length.to!int;
  int low = 0;
  int mid;
  while (high - low > 1) {
    mid = (high-low)/2 + low;
    if (c[mid].p == n)
      break;
    else if (c[mid].p > n)
      high = mid;
    else
      low = mid;
  }
  while (mid >= 1 && c[mid-1].p == n)
    mid -= 1;
  return mid;
}

void main() {
  auto input = readln.split.map!(to!int);
  int N = input[0];
  int S = input[1];
  auto P = iota(N).map!(_ => readln.chomp.to!int).array;

  auto P1 = new int[](1 << (N/2));
  auto P2 = new comb[](1 << (N/2+N%2));

  foreach (i; 0..(1 << (N/2))) {
    int s = 0;
    foreach (j; 0..(N/2))
      if (i & (1 << j))
        s += P[j];
    P1[i] = s;
  }
  foreach (i; 0..(1 << (N/2+N%2))) {
    int s = 0;
    foreach (j; 0..(N/2+N%2))
      if (i & (1 << j))
        s += P[j+N/2];
    P2[i] = comb(s, i);
  }
  P2.sort;

  int[][] ans;
  foreach (i; 0..(1 << (N/2))) {
    int m = binarySearch(S-P1[i], P2);
    while (m < (1<<(N/2+N%2)) && P2[m].p == S-P1[i]) {
      int[] a;
      foreach (k; 0..N/2)
        if (i & (1 << k))
          a ~= (k+1);
      foreach (k; 0..(N/2+N%2))
        if (P2[m].b & (1 << k))
          a ~= (k+N/2+1);
      ans ~= a;
      m += 1;
    }
  }

  foreach (a; ans.sort)
    writeln(a.map!(to!string).join(" "));
}


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
  auto S = readln.chomp;
  auto m = count(S, 'M');
  if (m == 0) {writeln(0); return;}
  auto A = new int[](m);
  auto cnt = 0;
  int acm;
  foreach (i; iota(S.length.to!int-1, -1, -1)) {
    if (S[i] == '+') acm += 1;
    else if (S[i] == '-') acm -= 1;
    else {A[cnt] = acm; cnt += 1;}
  }
  A.sort();
  writeln(A[m/2..m].sum - (A[0..m/2].sum));
}

import std.stdio;
import std.array;
import std.string;
import std.conv;
import std.algorithm;
import std.typecons;
import std.range;
import core.stdc.stdlib;

void main() {
  long N = readln().chomp.to!long;
  long[] factors;

  long i = 1;
  while (i*i <= N) {
    if (N % i == 0) {
      factors ~= i;
      factors ~= N/i;
    }
    i++;
  }

  long ans = long.max;
  foreach (a; factors) {
    foreach (b; factors) {
      if (N/a%b == 0) {
        long c = N/a/b;
        ans = min(ans, a+b+c-3);
      }
    }
  }
  writeln(ans, " ", N-1);
}


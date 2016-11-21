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
  auto input = readln.split;
  int N = input[0].to!int;
  long M = input[1].to!long;
  
  auto fib = new long[](N);
  fib[0] = 1;
  fib[1] = 1;
  foreach (i; 2..N)
    fib[i] = fib[i-1] + fib[i-2];

  int ans = 0;
  M = fib[N-1] - M;
  if (M < 0) {
    writeln(-1);
    return;
  }
  foreach (i; iota(N-3, -1, -1))
    if (M - fib[i] >= 0) {
      ans += 1;
      M -= fib[i];
    }

  writeln(ans);
}


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
  long MOD = 10^^9+7;
  auto s = readln.split.map!(to!int).array;
  auto N = s[0];
  auto K = s[1];

  auto f = new long[](N+1);
  f[0] = 1;
  f[1] = 1;
  foreach (i; 2..N+1)
    f[i] = f[i-1] * i % MOD;

  if (K == 0) {
    writeln(f[N]);
    return;
  }
  
  auto A = readln.split.map!(to!long).array.sort().array;

  foreach (i; 0..K)
    foreach (j; i+1..K)
      if ((A[i] & A[j]) != A[i]) {
        writeln(0);
        return;
      }


  
  long ans = 1;
  int cnt = 0;
  foreach (a; A) {
    (ans *= f[a.popcnt - cnt]) %= MOD;
    cnt = a.popcnt;
  }
  writeln(ans * f[N - cnt] % MOD);
}


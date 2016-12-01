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


long powmod(long x, long y, long z) {
  long number = 1;
  while (y) {
    if (y & 1)
      number = number * x % z;
    y >>= 1;
    x = x * x % z;
  }
  return number;
}


void main() {
  
  auto input = readln.split;
  auto N = input[0].to!int;
  auto A = input[1].to!long;
  auto B = input[2].to!long;
  auto M = readln.split.map!(to!long).array.sort();
  long MOD = 10L^^9+7;
  if (A == 1) {M.each!(m => (m%MOD).writeln); return;}

  long nokori = 0;
  foreach (i; 0..B) {
    auto mul = M[0]*A;
    if (mul >= M[$-1]) {nokori = B - i; break;}
    M[0] *= A;
    M.sort();
  }

  foreach (i; 0..N) {
    if (nokori - i > 0) 
      M[i] = M[i] * powmod(A, (nokori-i-1)/N+1, MOD) % MOD;
    else
      M[i] %= MOD;
  }
  
  iota(N).each!(i => M[((i+nokori)%N).to!int].writeln);
  
}

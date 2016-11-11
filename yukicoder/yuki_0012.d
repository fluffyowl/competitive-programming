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
  int N = readln.chomp.to!int;
  bool[10] A;
  foreach (i; readln.split.map!(to!int))
    A[i] = true;
  
  int MAX = 5000000;
  auto pt = new bool[](MAX+1);
  foreach (i; 2..MAX+1) 
    pt[i] = true;
  foreach (i; 2..MAX+1)
    if (pt[i])
      foreach (j; iota(i+i, MAX+1, i))
        pt[j] = false;
  int[] primes;
  foreach (i; 2..MAX+1)
    if (pt[i])
      primes ~= i;
  primes = 0 ~ primes ~ [MAX+1];

  bool[10] count;
  
  int left = 1;
  int right = 1;
  int ans = -1;
  while (right < primes.length-1) {
    foreach (c; primes[right].to!string)
      count[c.to!int-48] = true;
    if (all(iota(10).map!(i => A[i]==count[i]))) {
      ans = max(ans, (primes[right+1]-1)-(primes[left-1]+1));
      right += 1;
    }
    else if (all(iota(10).map!(i => !(!A[i] && count[i])))) {
      right += 1;
    }
    else  {
      right += 1;
      left = right;
      foreach (i; 0..10)
        count[i] = false;
    }
  }
  writeln(ans);
}


import std.stdio;
import std.array;
import std.string;
import std.conv;
import std.algorithm;
import std.typecons;
import std.range;

void main() {
  int N = readln().chomp.to!int;
  int[] A= readln().split.map!(to!int).array;

  bool[2^^15] dp;
  dp[0] = true;

  foreach (a; A) 
    foreach (i; iota(2^^15))
      if (dp[i])
        dp[i^a] = true;

  int ans = 0;
  foreach (i; iota(2^^15))
    if (dp[i])
      ans += 1;
  writeln(ans);
}


import std.stdio;
import std.array;
import std.string;
import std.conv;
import std.algorithm;
import std.typecons;
import std.range;

void main() {
  int N = readln().chomp.to!int;
  int[] x = readln().split.map!(to!int).array.sort;
  int m = reduce!(max)(x);
  int[] dp = new int[](m+1);
  dp[] = 0;
  
  foreach (a; x)
    dp[a] = 1;

  int b, c;
  foreach (a; x) {
    b = a*2;
    c = dp[a];
    while (b <= m) {
      if (dp[b] > 0)
	dp[b] = max(c+1, dp[b]);
      b += a;
    }
  }

  writeln(reduce!(max)(dp));
}


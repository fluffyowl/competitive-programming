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


void main() {
  auto input = readln.split.map!(to!long);
  auto R = input[0];
  auto C = input[1];
  auto K = input[2];
  auto B = iota(R).map!(_ => readln.chomp.array).array;

  foreach (i; 0..R)
    foreach (j; 0..C)
      if (B[i][j] == 'x')
        foreach (ni; (i-K+1)..(i+K))
          foreach (nj; (j-K+1)..(j+K))
            if (ni >= 0 && ni < R && nj >= 0 && nj < C &&
                abs(ni-i)+abs(nj-j) <= K-1 && B[ni][nj] != 'x')
              B[ni][nj] = '*';

  int ans = 0;
  foreach (i; K-1..(R-K+1))
    foreach (j; K-1..(C-K+1))
      if (i >= 0 && i < R && j >= 0 && j < C && B[i][j] == 'o')
        ans += 1;
  writeln(ans);
}

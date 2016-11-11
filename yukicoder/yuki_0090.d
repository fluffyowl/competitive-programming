import std.stdio;
import std.array;
import std.string;
import std.conv;
import std.algorithm;
import std.typecons;
import std.range;

void main() {
  string[] input = readln().split;
  int N = input[0].to!int();
  int M = input[1].to!int();
  Tuple!(int, int, int)[] iis = new Tuple!(int, int, int)[M];
  for (int i = 0; i < M; i++) {
    input = readln().split;
    iis[i] = tuple(input[0].to!int, input[1].to!int, input[2].to!int);
  }

  int m1 = 0;
  int m2;
  foreach (p; iota(N).permutations){
    m2 = 0;
    for (int i = 0; i < M; i++)
      if (p[iis[i][0]] < p[iis[i][1]])
	m2 += iis[i][2];
    if (m2 > m1)
      m1 = m2;
  }
  writeln(m1);
}


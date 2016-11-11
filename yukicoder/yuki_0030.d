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

alias Tuple!(int, uint) edge;
edge[][] rinsetsu;
uint[int] mem;

uint rec(int n) {
  if (n in mem)
    return mem[n];
  mem[n] = 0;
  foreach (m; rinsetsu[n])
    mem[n] += rec(m[0]) * m[1];
  return mem[n];
}

void main() {
  int N = readln.chomp.to!int;
  int M = readln.chomp.to!int;
  rinsetsu = new edge[][](N);
  auto is_leaf = iota(N).map!(_ => true).array;
  foreach (i; iota(M)) {
    auto input = readln.split.map!(to!int);
    rinsetsu[input[0]-1] ~= edge(input[2]-1, input[1]);
    is_leaf[input[2]-1] = false;
  }
  mem[N-1] = 1;
  foreach (i; iota(N-1)) {
    if (is_leaf[i])
      writeln(rec(i));
    else
      writeln(0);
  }
}


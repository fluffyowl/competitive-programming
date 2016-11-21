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

double[Tuple!(int, int)] mem;
int P_init, Q;

double rec(int p, int depth){
  if (depth >= 20)
    return 1.0;
  if (tuple(p, depth) in mem)
    return mem[tuple(p, depth)];

  mem[tuple(p, depth)] = p / 200.0 + (100-p) / 300.0
                       + p / 200.0 * rec(max(p-Q, 0), depth+1)
                       + (100-p) / 300.0 * rec(min(p+Q, 100), depth+1);
  
  return mem[tuple(p, depth)];
}

void main() {
  auto input = readln.split.map!(to!int);
  P_init = input[0];
  Q = input[1];

  writef("%.07f", 1.0/3 + rec(P_init, 0) / 3.0);
}


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
  int B = readln.chomp.to!int;
  int N = readln.chomp.to!int;
  auto C = iota(N).map!(_ => readln.chomp.to!long).array;
  auto count = (long n) {return sum(C.map!(c => abs(c.to!long-n)));};

  long high = (sum(C)+B)/N+1;
  long low = 0;
  while (high - low > 2) {
    long m1 = (high-low)/3 + low;
    long m2 = (high-low)/3*2 + low;
    if (count(m1) >= count(m2))
      low = m1;
    else
      high = m2;
  }
  writeln([low, low+1].map!(count).reduce!"min(a,b)");
}


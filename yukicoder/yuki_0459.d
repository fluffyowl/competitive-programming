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
  alias Tuple!(int, "index", int, "pos", int[3], "block") pack;

  auto s = readln.split.map!(to!int);
  auto H = s[0];
  auto W = s[1];
  auto N = s[2];
  auto COLS = new int[](W);
  foreach (i; 0..H)
    foreach (j, c; enumerate(readln.chomp))
      if (c == '#')
        COLS[j] += 1;
  auto P = new pack[](N);
  foreach (i; 0..N) {
    P[i].index = i;
    P[i].pos = readln.chomp.to!int;
  }

  P.sort!"a.pos < b.pos"();
  foreach (i; 0..N) 
    foreach (j; 0..3)
      if (COLS[P[i].pos+j] > 0) {
        COLS[P[i].pos+j] -= 1;
        P[i].block[j] += 1;
        break;
      }

  foreach (i; 0..N)
    foreach (j; 0..3)
      while (COLS[P[i].pos+j] > 0 && P[i].block[j] < 3) {
        COLS[P[i].pos+j] -= 1;
        P[i].block[j] += 1;
      }

  P.sort!"a.index < b.index"();
  foreach (i; 0..N) {
    foreach (j; 0..3) {
      char[3] line;
      foreach (k; 0..3)
        line[k] = (P[i].block[k] > j) ? '#' : '.';
      line.writeln;
    }
  }
}


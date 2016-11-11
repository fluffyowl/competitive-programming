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
  auto P = readln.split.map!(to!real).array;
  auto Q = iota(N).map!(_ => readln.split.map!(to!real).array).array;
  real ans = 0.0;

  foreach (i; iota(N))
    foreach (j; iota(i+1, N))
      foreach (k; iota(j+1, N)) {
        auto ij = [Q[j][0]-Q[i][0], Q[j][1]-Q[i][1], Q[j][2]-Q[i][2]];
        auto ik = [Q[k][0]-Q[i][0], Q[k][1]-Q[i][1], Q[k][2]-Q[i][2]];
        auto cross = [ij[1]*ik[2]-ij[2]*ik[1],
                      ij[2]*ik[0]-ij[0]*ik[2],
                      ij[0]*ik[1]-ij[1]*ik[0]];
        cross[] /= sqrt(cross[0]^^2+cross[1]^^2+cross[2]^^2);
        auto ip = [P[0]-Q[i][0], P[1]-Q[i][1], P[2]-Q[i][2]];
        ans += abs(cross[0]*ip[0]+cross[1]*ip[1]+cross[2]*ip[2]);
      }
  writef("%.09f", ans);
}


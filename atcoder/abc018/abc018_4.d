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
import core.bitop;


void main() {
  auto input = readln.split.map!(to!int);
  auto N = input[0];
  auto M = input[1];
  auto P = input[2];
  auto Q = input[3];
  auto R = input[4];
  auto choco = new Tuple!(int, int)[][](N);
  foreach (i; 0..R) {
    auto XYZ = readln.split.map!(to!int);
    choco[XYZ[0]-1] ~= tuple(XYZ[1]-1, XYZ[2]);
  }
  if (N*M*P*Q*R==0) {writeln(0); return;}

  int ans = 0;
  foreach (i; 0..(1<<N)) {
    if (popcnt(i) != P) continue;
    auto danshi = new int[](M);
    foreach (j; 0..N)
      if (i & (1<<j))
        foreach (k; choco[j])
          danshi[k[0]] += k[1];
    ans = max(ans, danshi.sort!"a>b"()[0..Q].reduce!"a+b");
  }
  writeln(ans);
}

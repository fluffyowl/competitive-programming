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
  auto N = readln.chomp.to!int;
  auto HS = iota(N).map!(_ => readln.split.map!(to!long).array).array;
  long high = 10L^^15;
  long low = -1;
  while (high - low > 1) {
    auto mid = (high + low) / 2;
    auto new_HS = HS.map!(hs => mid - hs[0] < 0 ? -1 : (mid-hs[0]) / hs[1]).array.sort();
    bool ok = true;
    foreach (i; 0..N) {
      if (new_HS[i] < i) {
        ok = false;
        break;
      }
    }
    if (ok) high = mid;
    else low = mid;
  }
  writeln(high);
}

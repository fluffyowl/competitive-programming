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
import core.bitop;


void main() {
  auto mem = new real[][][](11, 11, 11);
  foreach (a; 1..11)
    foreach (b; 1..11)
      foreach (t; 0..11) {
        real high = 10.0L;
        real low = 1L;
        foreach (i; 0..100) {
          auto mid = (high + low) / 2.0L;
          if (pow(mid, a) * pow(log(mid), b) >= t)
            high = mid;
          else
            low = mid;
        }
        mem[a][b][t] = high;
    }

  auto M = readln.chomp.to!int;
  foreach (m; 0..M) {
    auto s = readln.split;
    auto a = s[0].to!int;
    auto b = s[1].to!int;
    auto t = s[2].to!real;
    if (a == 0)
      writefln("%.10f", pow(E, pow(t, 1.0L/b)));
    else if (b == 0)
      writefln("%.10f", pow(t, 1.0L/a));
    else {
      real high = mem[a][b][t.ceil.to!int];
      real low = mem[a][b][t.floor.to!int];
      foreach (i; 0..30) {
        auto mid = (high + low) / 2.0L;
        if (pow(mid, a) * pow(log(mid), b) >= t)
          high = mid;
        else
          low = mid;
        }
      writefln("%.10f", high);
    }
  }
}


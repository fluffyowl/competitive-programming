import std.stdio;
import std.array;
import std.string;
import std.conv;
import std.algorithm;
import std.typecons;
import std.range;
import std.random;

void main() {
  int N = readln().chomp.to!int;
  int K = readln().chomp.to!int;

  auto gen = Random(unpredictableSeed);
  double[] table = new double[](N+1);
  int win = 0;
  foreach (i; iota(10000000)) {
    int taro = 0;
    int jiro = 0;
    foreach (j; iota(N))
      taro += uniform(1, 7, gen);
    foreach (j; iota(N-K))
      jiro += uniform(1, 7, gen);
    foreach (k; iota(K))
      jiro += uniform(4, 7, gen);
    if (jiro > taro)
      win += 1;
  }
  writef("%.04f", to!double(win)/10000000.0);
}

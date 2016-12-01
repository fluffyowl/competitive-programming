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
  auto input = readln.split.map!(to!int).array;
  auto N = input[0];
  auto M = input[1];
  auto ST = new Tuple!(int, int, int)[](M);
  foreach (i; 0..M) {
    input = readln.split.map!(to!int).array;
    ST[i] = tuple(input[0]-1, input[1]-1, i+1);
  }
  ST.sort();

  auto imos = new int[](N+1);
  foreach (st; ST) {
    imos[st[0]] += 1;
    imos[st[1]+1] -= 1;
  }
  foreach (i; 1..N+1)
    imos[i] += imos[i-1];

  int[] not_ans;
  int j = 0;
  foreach (i; 0..N) {
    if (imos[i] != 1)
      continue;
    while (j < M) {
      if (ST[j][1] < i)
        j += 1;
      else if (ST[j][0] <= i && i <= ST[j][1]) {
        not_ans ~= ST[j][2];
        j += 1;
      }
      else
        break;
    }
  }

  writeln(M-not_ans.length);
  not_ans.sort();
  not_ans ~= N+10;
  j = 0;
  foreach (i; 1.. M+1) {
    if (i < not_ans[j])
      writeln(i);
    else if (i == not_ans[j])
      j += 1;
  }

}

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

bool isKadomatsu(int a, int b, int c) {
  return ((a > b && b < c && a != c) || (a < b && b > c && a != c));
}

bool rec(int[] A) {
  if (A.length < 3)
    return false;

  bool[] results;
  foreach (i; 0..A.length)
    foreach (j; (i+1)..A.length)
      foreach (k; (j+1)..A.length) {
        if (isKadomatsu(A[i], A[j], A[k]))
          results ~= rec(A[0..i] ~ A[i+1..j] ~ A[j+1..k] ~ A[k+1..$]);
        else
          results ~= true;
      }
  return !all(results);
}

void main() {
  auto N = readln.chomp.to!int;
  auto A = readln.split.map!(to!int).array;

  foreach (i; 0..A.length)
    foreach (j; (i+1)..A.length)
      foreach (k; (j+1)..A.length)
        if (isKadomatsu(A[i], A[j], A[k]) &&
            !rec(A[0..i] ~ A[i+1..j] ~ A[j+1..k] ~ A[k+1..$])) {
          writeln(i, " ", j, " ", k);
          return;
        }

  writeln(-1);
}


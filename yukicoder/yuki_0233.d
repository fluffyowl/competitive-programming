import std.stdio;
import std.array;
import std.string;
import std.conv;
import std.algorithm;
import std.typecons;
import std.range;

void main() {
  int N = readln().chomp.to!int;
  bool[string] used;
  foreach (i; iota(N))
    used[readln().chomp] = true;

  string s1 = "ieau";
  string s2 = "nbmgr";
  auto p1 = [0, 1, 2, 2, 3, 3];
  do {
    auto p2 = [0, 1, 2, 3, 4];
    do {
      string s3 = "";
      foreach (i; iota(5)) {
        s3 ~= s2[p2[i]];
        s3 ~= s1[p1[i]];
      }

      foreach (i; iota(11)) {
        if (!(s3[0..i]~s1[p1[5]]~s3[i..$] in used)) { 
          writeln(s3[0..i]~s1[p1[5]]~s3[i..$]);
          return;
        }
      }
    } while(nextPermutation(p2));
  } while(nextPermutation(p1));
  
  writeln("NO");
}


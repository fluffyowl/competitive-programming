import std.stdio;
import std.array;
import std.string;
import std.conv;
import std.algorithm;
import std.typecons;
import std.range;

void main() {
  auto input = readln().split.map!(to!int);
  int H = input[0];
  int W = input[1];
  int N = readln().chomp.to!int;

  string[][] queries = new string[][](N, 2); 
  foreach (i; iota(N))
    queries[i] = readln().split;
    
  int[2] pos;
  foreach (i; iota(N-1, -1, -1)) {
    int n = queries[i][1].to!int;
    if (queries[i][0] == "R" && pos[0] == n)
       pos[1] = pos[1] == 0 ? W-1 : pos[1]-1;
    if (queries[i][0] == "C" && pos[1] == n)
       pos[0] = pos[0] == 0 ? H-1 : pos[0]-1;
  }
  writeln((pos[0]+pos[1])%2 == 0 ? "white" : "black");
}


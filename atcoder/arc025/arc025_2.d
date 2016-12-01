import std.stdio;
import std.array;
import std.string;
import std.conv;
import std.algorithm;
import std.typecons;
import std.range;
import std.container;

void main() {
  auto input = readln().split.map!(to!int).array;
  int H = input[0];
  int W = input[1];
  int[][] board = new int[][](H, W);
  foreach(i; iota(H)) {
    board[i] = readln().split.map!(to!int).array;
    foreach (j; iota(i%2, W, 2))
      board[i][j] *= -1;
  }

  int[][] c_sum = new int[][](H+1, W+1);
  c_sum[1][1] = board[0][0];

  foreach(i; iota(1, H+1))
    foreach(j; iota(1, W+1))
      c_sum[i][j] = c_sum[i-1][j] + c_sum[i][j-1] - c_sum[i-1][j-1] + board[i-1][j-1];

  int ans = 0;
  foreach(h; iota(1, H+1))
    foreach(w; iota(1, W+1))
      foreach(i; iota(1, H-h+2))
	foreach(j; iota(1, W-w+2)) {
	  int ni = i + h - 1;
	  int nj = j + w - 1;
	    if (c_sum[ni][nj] - c_sum[i-1][nj] - c_sum[ni][j-1] + c_sum[i-1][j-1] == 0)
	      ans = max(ans, h*w);
	}
  writeln(ans);
}

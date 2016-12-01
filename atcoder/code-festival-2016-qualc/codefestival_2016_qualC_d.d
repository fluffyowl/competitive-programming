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
  string[] blocks = new string[](H);
  foreach (i; iota(H))
    blocks[i] = readln().chomp;

  int ans = 0;
  foreach (w; iota(W-1)) {
    int[][] cost = new int[][](H+1, H+1);
    foreach (h1; iota(H, -1, -1)) {
      foreach (h2; iota(H-1, -1, -1)) {
        if (h1 == H || h2 == H) {
          cost[h1][h2] = 0;
        } else if (blocks[H-h1-1][w] == blocks[H-h2-1][w+1]){
          cost[h1][h2] = cost[h1+1][h2+1] + 1;
        } else {
          cost[h1][h2] = cost[h1+1][h2+1];
        }
      }
    }

    int[][] dp = new int[][](H+1, H+1);
    foreach (h1; iota(H+1)) {
      foreach (h2; iota(H+1)) {
        if (h1 == 0 && h2 == 0) {
          continue;
        } else if (h1 == 0) {
          dp[h1][h2] = dp[h1][h2-1] + cost[h1][h2-1];
        } else if (h2 == 0) {
          dp[h1][h2] = dp[h1-1][h2] + cost[h1-1][h2];
        } else {
          dp[h1][h2] = min(dp[h1][h2-1] + cost[h1][h2-1],
                           dp[h1-1][h2] + cost[h1-1][h2]);
        }
      }
    }
    ans += dp[H][H];
  }
  writeln(ans);
}

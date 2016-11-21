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

void main() {
  auto input = readln.split.map!(to!int);
  auto W = input[0];
  auto H = input[1];
  auto N = input[2];
  
  auto imos_tate = new int[][](H, W);
  auto imos_yoko = new int[][](H, W);
  
  foreach (n; 0..N) {
    auto M = readln.chomp.to!int;
    auto B = readln.split.map!(to!int);
    foreach (m; 0..M) {
      
      auto r1 = min(B[m], B[m+1]) / W;
      auto c1 = min(B[m], B[m+1]) % W;
      auto r2 = max(B[m], B[m+1]) / W;
      auto c2 = max(B[m], B[m+1]) % W;
      if (r1 == r2) {
        imos_yoko[r1][c1] += 1;
        imos_yoko[r1][c2] -= 1;
      }
      else {
        imos_tate[r1][c1] += 1;
        imos_tate[r2][c1] -= 1;
      }
    }
  }

  foreach (h; 0..H)
    foreach (w; 1..W)
      imos_yoko[h][w] += imos_yoko[h][w-1];
  foreach (h; 1..H)
    foreach (w; 0..W)
      imos_tate[h][w] += imos_tate[h-1][w];

  alias Tuple!(int, "r", int, "c", int, "depth") node;
  DList!node queue;
  queue.insert(node(0, 0, 0));
  auto visited = new bool[][](H, W);
  auto dr = [0, 0, 1, -1];
  auto dc = [1, -1, 0, 0];
  
  int hoge = 0;
  while (!queue.empty) {
    auto n = queue.front;
    queue.removeFront;
    
    if (n.r == H-1 && n.c == W-1) {writeln(n.depth); return;}
    if (visited[n.r][n.c]) continue;
    visited[n.r][n.c] = true;

    foreach (i; 0..4) {
      auto new_r = n.r + dr[i];
      auto new_c = n.c + dc[i];
      if (new_r < 0 || new_r >= H || new_c < 0 || new_c >= W) continue;
      if (visited[new_r][new_c]) continue;
      if ((i <= 1 && imos_yoko[n.r][min(n.c, new_c)]) ||
          (i >= 2 && imos_tate[min(n.r, new_r)][n.c]))
        queue.insert(node(new_r, new_c, n.depth+1));
    }
  }
  writeln("Odekakedekinai..");
}


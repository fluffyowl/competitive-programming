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
  return ((a < b && b > c && a != c) || (a > b && b < c && a != c));
}

void main() {
  auto input = readln.split.map!(to!int);
  int W = input[0];
  int H = input[1];
  int[][] B = new int[][](H, W);
  foreach (i; iota(H))
    B[i] = readln.split.map!(to!int).array;

  bool[int] visited;
  DList!(Tuple!(int, int, int, int)) queue;
  queue.insert(tuple(1, 0, B[0][0], 1));
  queue.insert(tuple(0, 1, B[0][0], 1));
  int row, col, prev, cost, nrow, ncol;
  int[4] dx = [0, 0, -1, 1];
  int[4] dy = [-1, 1, 0, 0];

  while (!queue.empty()) {
    auto node = queue.front;
    queue.removeFront();
    row = node[0];
    col = node[1];
    prev = node[2];
    cost = node[3];
    if (row == H-1 && col == W-1) { writeln(cost); return; }
    if (row*10000+col*100+prev in visited)
      continue;
    visited[row*10000+col*100+prev] = true;

    foreach (d; iota(4)) {
      nrow = row + dx[d];
      ncol = col + dy[d];
      if (nrow < 0 || nrow >= H || ncol < 0 || ncol >= W)
        continue;
      if (nrow*10000+ncol*100+B[row][col] in visited)
        continue;
      if (!isKadomatsu(prev, B[row][col], B[nrow][ncol]))
        continue;
      queue.insert(tuple(nrow, ncol, B[row][col], cost+1));
    }
  }
  writeln(-1);
}


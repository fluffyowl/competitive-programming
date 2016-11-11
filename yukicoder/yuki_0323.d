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

void main() {
  auto input = readln.split.map!(to!int);
  int H = input[0];
  int W = input[1];
  input = readln.split.map!(to!int);
  int A = input[0];
  int Si = input[1];
  int Sj = input[2];
  input = readln.split.map!(to!int);
  int C = input[0];
  int Gi = input[1];
  int Gj = input[2];
  string[] B = new string[](H);
  foreach (i; iota(H))
    B[i] = readln.chomp;

  DList!(Tuple!(int, int, int)) queue;
  queue.insert(tuple(Si, Sj, A));
  int i, j, s;
  Tuple!(int, int, int) node;
  bool[int][int][int] visited;
  int[4] dx = [0, 0, 1, -1];
  int[4] dy = [1, -1, 0, 0];
  while (!queue.empty()) {
    node = queue.front;
    queue.removeFront();
    i = node[0];
    j = node[1];
    s = node[2];
    //writeln(node);
    if (i == Gi && j == Gj && s == C) {
      writeln("Yes");
      return;
    }
    if (i in visited && j in visited[i] && s in visited[i][j])
      continue;
    visited[i][j][s] = true;

    foreach (k; iota(4)) {
      int ni = i + dx[k];
      int nj = j + dy[k];
      if (ni < 0 || ni >= H || nj < 0 || nj >= W)
        continue;
      int ns = B[ni][nj] == '*' ? s + 1 : s - 1;
      if (ns <= 0  || ns > 1200 || (ni in visited && nj in visited[ni] && ns in visited[ni][nj]))
        continue;
      queue.insert(tuple(ni, nj, ns));
    }
  }

  writeln("No");
}


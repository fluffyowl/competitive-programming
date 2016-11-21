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


class SegmentTree {
  int[] table;
  int N, table_size;

  this(int n) {
    N = n;
    table_size = 1;
    while (table_size < n) table_size *= 2;
    table_size *= 2;
    table = new int[](table_size);
  }

  void add(int pos, int num) {
    add_rec(0, 0, table_size/2-1, pos, num);
  }

  void add_rec(int i, int left, int right, int pos, int num) {
    table[i] += num;
    if (left == right)
      return;
    auto mid = (left + right) / 2;
    if (pos <= mid)
      add_rec(i*2+1, left, mid, pos, num);
    else
      add_rec(i*2+2, mid+1, right, pos, num);
  }

  int sum(int pl, int pr) {
    return sum_rec(0, pl, pr, 0, table_size/2-1);
  }

  int sum_rec(int i, int pl, int pr, int left, int right) {
    if (pl > right || pr < left)
      return 0;
    else if (pl <= left && right <= pr)
      return table[i];
    else
      return sum_rec(i*2+1, pl, pr, left, (left+right)/2) +
             sum_rec(i*2+2, pl, pr, (left+right)/2+1, right);
  }
}


void main() {
  auto score(int a, int b) {return 50*a + 500*a/(8+2*b);};
  alias Tuple!(int, "score", int, "order") Point;

  auto N = readln.chomp.to!int;
  auto L = readln.split.map!(to!int);
  Point[string] participants;
  Point[] points;
  auto ACed = new int[](N);

  auto T = readln.chomp.to!int;
  auto NP = new Tuple!(string, int, int)[](T);
  foreach (i; 0..T) {
    auto input = readln.split;
    if (input[1] == "?") {
      NP[i] = tuple(input[0], -1, -1);
      continue;
    }
    auto name = input[0];
    auto prob = input[1][0].to!int - 'A'.to!int;

    ACed[prob] += 1;
    if (name in participants)
      participants[name] = Point(participants[name].score + score(L[prob], ACed[prob]), i);
    else
      participants[name] = Point(score(L[prob], ACed[prob]), i);
    points ~= Point(-participants[name].score, i);
    NP[i] = tuple(name, participants[name].score, i);
  }

  points.sort();
  int[Point] ranks;
  foreach (i, p; points.enumerate)
    ranks[Point(-p.score, p.order)] = i.to!int;

  auto sg = new SegmentTree(100000);
  int[string] last;
  foreach (i; 0..T) {
    if (NP[i][2] == -1) {
      writeln(sg.sum(0, last[NP[i][0]]));
    }
    else {
      auto name = NP[i][0];
      auto rank = ranks[Point(NP[i][1], NP[i][2])];
      if (name in last)
        sg.add(last[name], -1);
      last[name] = rank;
      sg.add(rank, 1);
    }
  }
}


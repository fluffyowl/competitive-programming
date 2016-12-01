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

  void update(int pos, int num) {
    update_rec(0, 0, table_size/2-1, pos, num);
  }

  void update_rec(int i, int left, int right, int pos, int num) {
    table[i] = max(table[i], num);
    if (left == right)
      return;
    auto mid = (left + right) / 2;
    if (pos <= mid)
      update_rec(i*2+1, left, mid, pos, num);
    else
      update_rec(i*2+2, mid+1, right, pos, num);
  }

  int get_max(int pl, int pr) {
    return get_max_rec(0, pl, pr, 0, table_size/2-1);
  }

  int get_max_rec(int i, int pl, int pr, int left, int right) {
    if (pl > right || pr < left)
      return 0;
    else if (pl <= left && right <= pr)
      return table[i];
    else 
      return max(get_max_rec(i*2+1, pl, pr, left, (left+right)/2),
                 get_max_rec(i*2+2, pl, pr, (left+right)/2+1, right));
  }
}

void main() {
  alias Tuple!(int, "h", int, "w") box;
  auto N = readln.chomp.to!int;
  auto B = new box[](N);
  foreach (i; 0..N) {
    auto input = readln.split.map!(to!int);
    B[i] = box(input[0], -input[1]);
  }
  B.sort();
    
  auto sg = new SegmentTree(100000);
  auto dp = new int[](N);
  foreach (i; 0..N) {
    dp[i] = sg.get_max(0, -B[i].w-1) + 1;
    sg.update(-B[i].w, dp[i]);
  }

  writeln(dp.reduce!(max));
}

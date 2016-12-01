import std.stdio;
import std.array;
import std.string;
import std.conv;
import std.algorithm;
import std.typecons;
import std.range;
import std.random;
//import std.math;
import std.container;
import std.numeric;
import std.bigint;
import core.stdc.stdlib;


alias Tuple!(int, "lower", int, "upper") bound;
int N, K;
int[][] adj;
bound[] nums;
int[] ans;


bound bfs(int node, int prev, bound b) {
  if (nums[node].lower != int.min &&
      b.lower != int.min &&
      (b.lower > nums[node].upper ||
       b.upper < nums[node].lower ||
       abs(b.upper%2) != abs(nums[node].upper%2))) {
    //writeln(node, " ", b, " ", nums[node]);
    //writeln(nums);
    writeln("No");
    exit(0);
  }
  nums[node].lower = max(nums[node].lower, b.lower);
  nums[node].upper = min(nums[node].upper, b.upper);

  foreach (child; adj[node]) {
    if (child == prev) continue;
    auto ret_b = bfs(child, node, bound(nums[node].lower-1, nums[node].upper+1));
    if (nums[node].lower != int.min &&
        ret_b.lower != int.min &&
        (ret_b.lower > nums[node].upper+1 ||
         ret_b.upper < nums[node].lower-1 ||
         abs(ret_b.upper%2) == abs(nums[node].upper%2))) {
      //writeln(child, " ", ret_b, " ", nums[node]);
      //writeln(nums);
      writeln("No");
      exit(0);
    }
    nums[node].lower = max(nums[node].lower, ret_b.lower-1);
    nums[node].upper = min(nums[node].upper, ret_b.upper+1);
  }
  return nums[node];
}


void dfs(int node, int prev, int prev_n) {
  if (nums[node].lower == nums[node].upper)
    ans[node] = nums[node].lower;
  else if (prev_n + 1 <= nums[node].upper)
    ans[node] = prev_n + 1;
  else
    ans[node] = prev_n - 1;

  foreach (child; adj[node])
    if (child != prev)
      dfs(child, node, ans[node]);
}

void main() {
  N = readln.chomp.to!int;
  adj = new int[][](N);
  foreach (i; 0..N-1) {
    auto input = readln.split.map!(to!int);
    adj[input[0]-1] ~= input[1]-1;
    adj[input[1]-1] ~= input[0]-1;
  }
  K = readln.chomp.to!int;
  nums = new bound[](N);
  foreach (i; 0..N) nums[i] = bound(int.min, int.max);
  int root;
  foreach (i; 0..K) {
    auto input = readln.split.map!(to!int);
    nums[input[0]-1] = bound(input[1], input[1]);
    root = input[0]-1;
  }

  bfs(root, -1, bound(int.min, int.max));

  ans = new int[](N);
  dfs(root, -1, nums[root].lower);
  "Yes".writeln;
  ans.each!(writeln);
}

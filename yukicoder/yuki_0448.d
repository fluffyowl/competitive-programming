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
  alias Tuple!(long, "t", long, "d") Task;
  auto input = readln.split;
  auto N = input[0].to!int;
  auto K = input[1].to!long;
  auto tasks = new Task[](N);
  foreach (i; 0..N) {
    input = readln.split;
    tasks[i] = Task(input[0].to!long, input[1].to!long);
  }
  
  long high = 10^^9;
  long low = -1;
  while (high - low > 1) {
    auto mid = (high - low) / 2 + low;
    auto last = -K-1;
    auto flag = true;
    foreach (task; tasks) {
      if (task.d > mid) {
        if (task.t - last < K) {
          flag = false;
          break;
        }
        else
          last = task.t;
      }
    }
    if (flag)
      high = mid;
    else
      low = mid;
  }

  long ans;

  long[] sleeps = [-K-1];
  foreach (task; tasks)
    if (task.d > high) 
      sleeps ~= task.t;
  sleeps ~= 10^^9 + K + 1;
  
  int last = 0;
  Task[] new_tasks;
  foreach (task; tasks) {
    if (task.d > high) {
      last += 1;
      ans += task.d;
    }
    else if (sleeps[last+1] - task.t >= K && task.t - sleeps[last] >= K)
      new_tasks ~= task;
  }

  auto M = new_tasks.length.to!int;
  auto dp = new long[](M);
  if (M == 0) {M += 1; dp ~= 0;}
  else {dp[0] = new_tasks[0].d;}
  last = -1;
  foreach (i; 1..M) {
    auto t = new_tasks[i].t;
    auto d = new_tasks[i].d;
    while (t - new_tasks[last+1].t >= K)
      last += 1;
    if (last >= 0)
      dp[i] = max(dp[i-1], dp[last]+d);
    else
      dp[i] = max(dp[i-1], d);
  }
  
  writeln(high);
  writeln(tasks.map!(t => t.d).sum - ans - dp[M-1]);
  
}


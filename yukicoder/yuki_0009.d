import std.stdio;
import std.array;
import std.string;
import std.conv;
import std.algorithm;
import std.typecons;
import std.range;
import std.container;

void main() {
  int N = readln().chomp.to!int;
  //auto C = readln().split.map!(to!int).array.heapify!"a > b";
  auto C = readln().split.map!(to!int);
  
  auto B = readln().split.map!(to!int).array;

  int ans = int.max;
  foreach (i; iota(N)) {
    int m = 0;
    Tuple!(int, int)[] D = new Tuple!(int, int)[](N);
    foreach (k; iota(N))
      D[k] = tuple(C[k], 0);
    auto A = D.heapify!"a > b";
    foreach (j; iota(N)) {
      Tuple!(int, int) top = A.front;
      A.removeFront;
      A.insert(tuple(top[0]+B[(i+j)%N]/2, top[1]+1));
    }
    foreach(a; A.take(N))
      if (a[1] > m)
        m = a[1];
    ans = min(ans, m);
  }

  writeln(ans);
}

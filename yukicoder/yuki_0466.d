import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;


void w(int a, int b) {writeln(a, " ", b);}

void main() {
  int A, B, C, D;
  scanf("%d %d %d %d", &A, &B, &C, &D);

  if (A == C && B == C) {
    if (C == 1 || D < C) {writeln(-1); return;}
    w(C, C);
    w(0, 1);
    w(1, 0);
    foreach (i; 2..C)
      w(0, i);
  }
  
  else if (A == C) {
    if (D < B-1) {writeln(-1); return;}
    w(B, B-1);
    foreach (i; 2..A+1)
      w(0, i);
    w(1, 0);
    foreach (i; 0..B-A-1)
      w(1, A+1+i);
  }
  
  else if (B == C) {
    if (D < A-1) {writeln(-1); return;}
    w(A, A-1);
    foreach (i; 2..B+1)
      w(1, i);
    w(0, 1);
    foreach (i; 0..A-B-1)
      w(0, B+1+i);
  }
  
  else {
    int nodes = A + B - C;
    int edges = (A - C - 1) + (B - C - 1) + (C > 0 ? C + 1 : 0);
    if (D < edges) {writeln(-1); return;}

    w(nodes, edges);
    int n = 1;
    if (C > 0) {
      w(0, 2);
      w(1, 2);
      n++;
      foreach (i; 0..C-1) {
        w(n, n+1);
        n++;
      }
    }

    if (A - C - 1 > 0) {
      n++;
      w(0, n);
      foreach (i; 0..A-C-2) {
        w(n, n+1);
        n++;
      }
    }

    if (B - C - 1 > 0) {
      n++;
      w(1, n);
      foreach (i; 0..B-C-2) {
        w(n, n+1);
        n++;
      }
    }
  }
}


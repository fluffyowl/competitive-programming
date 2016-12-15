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
import std.bigint;


void main() {
  auto S = readln.chomp;
  auto N = S.length.to!int;
  auto right_p = new int[](N+1);
  foreach (i; 0..N)
    if (S[i] == ')')
      right_p[i+1] = 1;
  foreach (i; 0..N)
    right_p[i+1] += right_p[i];

  int l_ans;
  foreach (i; 0..N) {
    int left;
    if (S[i] == '(') {
      foreach (j; i+1..N) {
        if (S[j] == '^')
          left = (left < 3) ? min(2, left+1) : 3;
        else if (S[j] == '*')
          left = (left == 2) ? 3 : left;
        if (left == 3) {
          l_ans += right_p[N] - right_p[j];
          break;
        }
      }
    }
  }

  int r_ans;
  foreach (i; 0..N) {
    int right;
    if (S[i] == '(') {
      foreach (j; i+1..N) {
        if (S[j] == '*')
          right = (right == 0) ? 1 : right;
        else if (S[j] == '^')
          right = (right > 0) ? min(3, right+1) : 0;
        if (right == 3) {
          r_ans += right_p[N] - right_p[j];
          break;
        }
      }
    }
  }

  writeln(l_ans, " ", r_ans);

}


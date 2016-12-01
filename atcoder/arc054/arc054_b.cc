#include <iostream>
#include <stdio.h>
#include <math.h>
using namespace std;

double P;

double f(double x) {
  return P / pow(2, x/1.5) + x;
}

int main() {
  cin >> P;
  double eps = pow(10, -8);
  double max = P;
  double min = 0;
  double a, b;

  while (max - min > eps) {
    a = (max-min)/3 + min;
    b = (max-min)/3*2 + min;
    if (f(a) <= f(b))
      max = b;
    else
      min = a;
  }

  printf("%.10f\n", f(max));
  return 0;
}

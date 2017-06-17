#include <iostream>
#include <math.h>
using namespace std;

int main() {
  long long int N;
  cin >> N;

  for (int i = (int)sqrtl(N)+1; i >= 1; i--) {
    if (N%i == 0) {
      cout << i << " " << N / i << endl;
      break;
    }
  }

  return 0;
}


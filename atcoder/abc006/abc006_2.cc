#include <iostream>
#include <vector>
using namespace std;

int main() {
  long long int mod = 10007;
  long long int i, n;
  cin >> n;
  vector <long long int> trib(n);
  trib[0] = 0;
  trib[1] = 0;
  trib[2] = 1;

  for (i = 3; i < n; i++)
    trib[i] = (trib[i-1] + trib[i-2] + trib[i-3]) % mod;

  cout << trib[n-1] << endl;
  
  return 0;
}

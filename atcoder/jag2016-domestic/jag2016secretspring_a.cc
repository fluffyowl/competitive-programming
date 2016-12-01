#include <iostream>
using namespace std;

int main() {
  int c, i, n;
  string s;
  cin >> n;
  c = 0;
  for (i = 0; i < n; i++) {
    cin >> s;
    if (s == "A")
      c++;
    else
      c--;
    if (c < 0) {
      break;
    }
  }
  if (c == 0)
    cout << "YES" << endl;
  else
    cout << "NO" << endl;
  return 0;
}

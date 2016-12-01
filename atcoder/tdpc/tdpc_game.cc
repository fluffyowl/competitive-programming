#include <iostream>
#include <algorithm>
#include <utility>
#include <map>
using namespace std;

int A, B;
int a[1001], b[1001];
pair<int, int> kekka[1010][1010];

int main() {
  int i, j;
  pair<int, int> k1, k2;
  
  cin >> A >> B;
  for (i = 0; i < A; i++)
    cin >> a[i];
  for (i = 0; i < B; i++)
    cin >> b[i];

  for (i = A; i >= 0; i--) {
    for (j = B; j >= 0; j--) {
      if (i == A && j == B) {
	kekka[i][j] = make_pair(0, 0);
	continue;
      }

      if ((i+j)%2 == 0) {
	if (i == A) 
	  kekka[i][j] = make_pair(kekka[i][j+1].first + b[j], kekka[i][j+1].second);
	else if (j == B)
	  kekka[i][j] = make_pair(kekka[i+1][j].first + a[i], kekka[i+1][j].second);
	else {
	  k1 = make_pair(kekka[i][j+1].first + b[j], kekka[i][j+1].second);
	  k2 = make_pair(kekka[i+1][j].first + a[i], kekka[i+1][j].second);
	  if (k1.first >= k2.first)
	    kekka[i][j] = k1;
	  else
	    kekka[i][j] = k2;
	}
      }
      else {
	if (i == A) 
	  kekka[i][j] = make_pair(kekka[i][j+1].first, kekka[i][j+1].second + b[j]);
	else if (j == B)
	  kekka[i][j] = make_pair(kekka[i+1][j].first, kekka[i+1][j].second + a[i]);
	else {
	  k1 = make_pair(kekka[i][j+1].first, kekka[i][j+1].second + b[j]);
	  k2 = make_pair(kekka[i+1][j].first, kekka[i+1][j].second + a[i]);
	  if (k1.second >= k2.second)
	    kekka[i][j] = k1;
	  else
	    kekka[i][j] = k2;
	}
      }
    }
  }

  cout << kekka[0][0].first << endl;
  
  return 0;
}

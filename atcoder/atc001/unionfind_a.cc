#include <stdio.h>
#include <vector>
using namespace std;

class UnionFind {
private:
  vector<int> table;
public:
  UnionFind(int n);
  ~UnionFind();
  bool uni(int x, int y);
  int find(int x);
};

UnionFind::UnionFind(int n) {
  table = vector<int>(n, -1);
}

UnionFind::~UnionFind(){}

int UnionFind::find(int x) {
  vector<int> children;
  while (table[x] >= 0) {
    children.push_back(x);
    x = table[x];
  }
  for (auto n : children)
    table[n] = x;
  return x;
}

bool UnionFind::uni(int x, int y) {
  int s1 = find(x);
  int s2 = find(y);
  if (s1 == s2)
    return false;

  if (table[s1] >= table[s2]) {
      table[s1] += table[s2];
      table[s2] = s1;
    }
  else {
      table[s2] += table[s1];
      table[s1] = s2;
    }
  return true;
}

int main(){
  int N, Q;
  scanf("%d%d", &N, &Q);
  int p, a, b;
  UnionFind uf = UnionFind(N);
  for (int i = 0; i < Q; i++) {
    scanf("%d%d%d", &p, &a, &b);
    if (p == 0) {
      uf.uni(a, b);
    } else if (uf.find(a) == uf.find(b)) {
      printf("Yes\n");
    } else {
      printf("No\n");
    }
  }
  return 0;
}

class UnionFind {
public:
  vector<int> table;
  UnionFind(int n) {
    table = vector<int> (n, -1);
  }

  ~UnionFind(){};

  void unite(int x, int y) {
    x = find(x);
    y = find(y);
    if (x == y) return;
    if (table[x] >= table[y]) {
      table[y] += table[x];
      table[x] = y;
    } else {
      table[x] += table[y];
      table[y] = x;
    }
  }

  int find(int x) {
    if (table[x] < 0) return x;
    return table[x] = find(table[x]);
  }
};

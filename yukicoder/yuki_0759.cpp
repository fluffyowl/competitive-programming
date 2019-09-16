#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;

const int M = 10001;
typedef bitset<M> bs;
const bs zero = bs(0);

int N;
vector<int> A[101010];
vector<int> B[101010];
bool ng[101010];


class SegmentTree {
public:
    vector<bs> table;
    int size;
    int offset;

    SegmentTree(int n) {
        size = 1;
        while (size <= n) size <<= 1;
        size <<= 2;
        table = vector<bs>(size);
        offset = size / 2;
    }

    void add(int pos, int num) {
        pos += offset;
        table[pos][num] = true;
        while (pos > 1) {
            pos /= 2;
            table[pos][num] = true;
        }
    }

    bs query(int l, int r) {
        vector<int> hoge;
        query(l, r, 1, 0, offset-1, hoge);
        bs ret = zero;
        for (auto i: hoge) ret |= table[i];
        return ret;
    }

    void query(int l, int r, int i, int a, int b, vector<int>& hoge) {
        if (b < l || r < a) {

        } else if (l <= a && b <= r)
            hoge.push_back(i);
        else {
            query(l, r, i*2, a, (a+b)/2, hoge);
            query(l, r, i*2+1, (a+b)/2+1, b, hoge);
        }
    }
};


void solve2(int x) {
    REP(i, N) B[i] = A[i];
    REP(i, N) swap(B[i][0], B[i][x]);
    sort(B, B+N);

    SegmentTree st = SegmentTree(M);

    for (int i = N - 1, j = N - 1; i >= 0; --i) {
        while (j >= 0 && B[j][0] > B[i][0]) {
            st.add(B[j][1], B[j][2]);
            --j;
        }

        bs b = st.query(B[i][1], M);
        b >>= B[i][2];
        if (b.count()) ng[B[i][3]] = true;
    }
}

void solve() {
    cin >> N;
    REP(i, N) {
        A[i] = vector<int>(4);
        REP(j, 3) cin >> A[i][j];
        A[i][3] = i;
    }

    solve2(0);
    solve2(1);
    solve2(2);

    REP(i, N) if (!ng[i]) cout << i+1 << "\n";
}

int main() {
    cin.tie(0);
    ios::sync_with_stdio(false);

    solve();
}


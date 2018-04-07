#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

const ll INF = 1000000;

class SegmentTree {
public:
    vector<ll> table;
    int size;

    SegmentTree(int n) {
        size = 1;
        while (size <= n) size *= 2;
        size *= 2;
        table = vector<ll>(size, 0);
    }

    void add(int pos, ll num) {
        return add(pos, num, 0, 0, size/2-1);
    }

    void add(int pos, ll num, int i, int left, int right) {
        table[i] += num;
        if (left == right)
            return;
        auto mid = (left + right) / 2;
        if (pos <= mid)
            add(pos, num, i*2+1, left, mid);
        else
            add(pos, num, i*2+2, mid+1, right);
    }

    ll sum(int pl, int pr) {
        return sum(pl, pr, 0, 0, size/2-1);
    }

    ll sum(int pl, int pr, int i, int left, int right) {
        if (pl > right || pr < left)
            return 0;
        else if (pl <= left && right <= pr)
            return table[i];
        else
            return
                sum(pl, pr, i*2+1, left, (left+right)/2) +
                sum(pl, pr, i*2+2, (left+right)/2+1, right);
    }
};

ll N, X;
ll T[101010];
ll A[101010];
pair<ll, ll> TA[101010];

int main() {
    cin >> N >> X;
    REP(i, N) cin >> T[i];
    REP(i, N) cin >> A[i];
    REP(i, N) {
        TA[i] = make_pair(-A[i], T[i]);
    }
    sort(TA, TA+N);

    SegmentTree st = SegmentTree(INF);
    ll tmp = 0;

    REP(i, N) {
        ll t = TA[i].second;
        ll a = -TA[i].first;
        if (st.sum(0, t) >= t) {
            continue;
        }
        tmp += a;
        st.add(t, 1);
        if (tmp >= X) {
            break;
        }
    }

    if (tmp < X) {
        cout << -1 << endl;
    } else {
        cout << st.sum(0, INF) << endl;
    }
}

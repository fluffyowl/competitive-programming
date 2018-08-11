#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

const ll MAX = 1000000007;
const ll MOD = 1LL << 31;
ll A[101010];
ll B[101010];

class SegmentTree {
public:
    vector<ll> table;
    int size;

    SegmentTree(int n) {
        size = 1;
        while (size <= n) size *= 2;
        size *= 2;
        table = vector<ll>(size);
    }

    void assign(int pos, ll num) {
        num = min(num, MAX);
        return assign(pos, num, 0, 0, size/2-1);
    }

    void assign(int pos, ll num, int i, int left, int right) {
        if (left == right) {
            table[i] = num;
            return;
        }
        auto mid = (left + right) / 2;
        if (pos <= mid)
            assign(pos, num, i*2+1, left, mid);
        else
            assign(pos, num, i*2+2, mid+1, right);
        table[i] = table[i*2+1] * table[i*2+2];
        table[i] = min(table[i], MAX);
    }

    ll sum(int pl, int pr) {
        return sum(pl, pr, 0, 0, size/2-1);
    }

    ll sum(int pl, int pr, int i, int left, int right) {
        if (pl > right || pr < left)
            return 1;
        else if (pl <= left && right <= pr)
            return table[i];
        else {
            ll ret =
                sum(pl, pr, i*2+1, left, (left+right)/2) *
                sum(pl, pr, i*2+2, (left+right)/2+1, right);
            return min(ret, MAX);
        }
    }
};


class ProductThreshold {
    public:
    ll solve(int l, int r) {

    }

    long long subarrayCount(int N, int limit, vector<int> Aprefix, int spread, int offset) {
        int p = Aprefix.size();
        for (int i = 0; i < p; ++i) {
            A[i] = Aprefix[i];
        }
        ll seed = A[p-1];
        for (int i = p; i < N; ++i) {
            seed = (seed * (1103515245LL % MOD) % MOD + 12345) % MOD;
            A[i] = seed % spread + offset;
        }

        for (int i = 0; i < N; ++i) {
            B[i] = abs(A[i]);
        }

        SegmentTree st = SegmentTree(N);
        REP(i, N) st.assign(i, B[i]);

        return 0;
    }
};



// CUT begin
ifstream data("ProductThreshold.sample");

string next_line() {
    string s;
    getline(data, s);
    return s;
}

template <typename T> void from_stream(T &t) {
    stringstream ss(next_line());
    ss >> t;
}

void from_stream(string &s) {
    s = next_line();
}

template <typename T> void from_stream(vector<T> &ts) {
    int len;
    from_stream(len);
    ts.clear();
    for (int i = 0; i < len; ++i) {
        T t;
        from_stream(t);
        ts.push_back(t);
    }
}

template <typename T>
string to_string(T t) {
    stringstream s;
    s << t;
    return s.str();
}

string to_string(string t) {
    return "\"" + t + "\"";
}

bool do_test(int N, int limit, vector<int> Aprefix, int spread, int offset, long long __expected) {
    time_t startClock = clock();
    ProductThreshold *instance = new ProductThreshold();
    long long __result = instance->subarrayCount(N, limit, Aprefix, spread, offset);
    double elapsed = (double)(clock() - startClock) / CLOCKS_PER_SEC;
    delete instance;

    if (__result == __expected) {
        cout << "PASSED!" << " (" << elapsed << " seconds)" << endl;
        return true;
    }
    else {
        cout << "FAILED!" << " (" << elapsed << " seconds)" << endl;
        cout << "           Expected: " << to_string(__expected) << endl;
        cout << "           Received: " << to_string(__result) << endl;
        return false;
    }
}

int run_test(bool mainProcess, const set<int> &case_set, const string command) {
    int cases = 0, passed = 0;
    while (true) {
        if (next_line().find("--") != 0)
            break;
        int N;
        from_stream(N);
        int limit;
        from_stream(limit);
        vector<int> Aprefix;
        from_stream(Aprefix);
        int spread;
        from_stream(spread);
        int offset;
        from_stream(offset);
        next_line();
        long long __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(N, limit, Aprefix, spread, offset, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1530980305;
        double PT = T / 60.0, TT = 75.0;
        cout << "Time   : " << T / 60 << " minutes " << T % 60 << " secs" << endl;
        cout << "Score  : " << 500 * (0.3 + (0.7 * TT * TT) / (10.0 * PT * PT + TT * TT)) << " points" << endl;
    }
    return 0;
}

int main(int argc, char *argv[]) {
    cout.setf(ios::fixed, ios::floatfield);
    cout.precision(2);
    set<int> cases;
    bool mainProcess = true;
    for (int i = 1; i < argc; ++i) {
        if ( string(argv[i]) == "-") {
            mainProcess = false;
        } else {
            cases.insert(atoi(argv[i]));
        }
    }
    if (mainProcess) {
        cout << "ProductThreshold (500 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

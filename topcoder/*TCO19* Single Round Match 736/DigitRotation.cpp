#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

const ll MOD = 998244353;
ll A[555];

class DigitRotation {
    public:
    int sumRotations(string X) {
        A[0] = 1;
        REP2(i, 1, 555) A[i] = A[i-1] * 10 % MOD;
        int N = X.size();
        ll ans = 0;
        ll base = 0;
        REP(i, N) base = (base + (ll)(X[i] - '0') * A[N-i-1] % MOD) % MOD;

        REP(i, N) REP2(j, i+1, N) REP2(k, j+1, N) {
            if (i == 0 && X[k] == '0') continue;
            ll tmp = base;
            tmp = (tmp - (ll)(X[i] - '0') * A[N-i-1] % MOD) % MOD;
            tmp = (tmp - (ll)(X[j] - '0') * A[N-j-1] % MOD) % MOD;
            tmp = (tmp - (ll)(X[k] - '0') * A[N-k-1] % MOD) % MOD;
            tmp = (tmp + (ll)(X[i] - '0') * A[N-j-1] % MOD) % MOD;
            tmp = (tmp + (ll)(X[j] - '0') * A[N-k-1] % MOD) % MOD;
            tmp = (tmp + (ll)(X[k] - '0') * A[N-i-1] % MOD) % MOD;
            ans = (ans + tmp) % MOD;
            ans = (ans + MOD) % MOD;
        }

        return (int)ans;
    }
};

// CUT begin
ifstream data("DigitRotation.sample");

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

template <typename T>
string to_string(T t) {
    stringstream s;
    s << t;
    return s.str();
}

string to_string(string t) {
    return "\"" + t + "\"";
}

bool do_test(string X, int __expected) {
    time_t startClock = clock();
    DigitRotation *instance = new DigitRotation();
    int __result = instance->sumRotations(X);
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
        string X;
        from_stream(X);
        next_line();
        int __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(X, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1534345214;
        double PT = T / 60.0, TT = 75.0;
        cout << "Time   : " << T / 60 << " minutes " << T % 60 << " secs" << endl;
        cout << "Score  : " << 250 * (0.3 + (0.7 * TT * TT) / (10.0 * PT * PT + TT * TT)) << " points" << endl;
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
        cout << "DigitRotation (250 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

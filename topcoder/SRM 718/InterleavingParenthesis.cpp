#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

const ll MOD = 1000000007;

class InterleavingParenthesis {
    public:
    int countWays(string s1, string s2) {
        int N = s1.size();
        int M = s2.size();
        vector<int> A(N + 1, 0);
        vector<int> B(M + 1, 0);
        REP(i, N) A[i + 1] = A[i] + (s1[i] == '(');
        REP(i, M) B[i + 1] = B[i] + (s2[i] == '(');
        cout << A[N] << " " << B[M] << endl;

        if ((A[N] + B[M]) * 2 != N + M) return 0;


        vector<vector<ll>> dp(N + 1, vector<ll>(M + 1, 0));
        dp[0][0] = 1;

        REP(i, N + 1) REP(j, M + 1) {
            int open = A[i] + B[j] - (i + j - A[i] - B[j]);
            if (open > 0) {
                if (i < N) (dp[i + 1][j] += dp[i][j]) %= MOD;
                if (j < M) (dp[i][j + 1] += dp[i][j]) %= MOD;
            } else if (open == 0) {
                if (i < N && s1[i] == '(') (dp[i + 1][j] += dp[i][j]) %= MOD;
                if (j < M && s2[j] == '(') (dp[i][j + 1] += dp[i][j]) %= MOD;
            }
        }

        return dp[N][M];
    }
};

// CUT begin
ifstream data("InterleavingParenthesis.sample");

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

bool do_test(string s1, string s2, int __expected) {
    time_t startClock = clock();
    InterleavingParenthesis *instance = new InterleavingParenthesis();
    int __result = instance->countWays(s1, s2);
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
        string s1;
        from_stream(s1);
        string s2;
        from_stream(s2);
        next_line();
        int __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(s1, s2, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1501419386;
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
        cout << "InterleavingParenthesis (250 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

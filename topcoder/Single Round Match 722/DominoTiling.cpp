#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

ll dp[15][15][1 << 15];

class DominoTiling {
    public:
    long long count(vector<string> grid) {
        int N = grid.size();
        int M = grid[0].length();
        memset(dp, 0, sizeof(dp));
        dp[0][0][0] = 1;

        REP(i, N) REP(j, M) REP(mask, 1 << M) {
            if ((mask & (1 << j)) || (grid[i][j] == 'X')) {
                int next = mask & ~(1 << j);
                if (j + 1 < M)
                    dp[i][j+1][next] += dp[i][j][mask];
                else
                    dp[i+1][0][next] += dp[i][j][mask];
            } else {
                if (j+1 < M && grid[i][j+1] != 'X' && !(mask & (1 << (j+1)))) {
                    int next = mask | (1 << (j+1));
                    dp[i][j+1][next] += dp[i][j][mask];
                }
                if (i+1 < N && grid[i+1][j] != 'X') {
                    int next = mask | (1 << j);
                    if (j + 1 < M)
                        dp[i][j+1][next] += dp[i][j][mask];
                    else
                        dp[i+1][0][next] += dp[i][j][mask];
                }
            }

        }
        return dp[N-1][M-1][1 << (M - 1)];
    }
};

// CUT begin
ifstream data("DominoTiling.sample");

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

bool do_test(vector<string> grid, long long __expected) {
    time_t startClock = clock();
    DominoTiling *instance = new DominoTiling();
    long long __result = instance->count(grid);
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
        vector<string> grid;
        from_stream(grid);
        next_line();
        long long __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(grid, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1507807429;
        double PT = T / 60.0, TT = 75.0;
        cout << "Time   : " << T / 60 << " minutes " << T % 60 << " secs" << endl;
        cout << "Score  : " << 600 * (0.3 + (0.7 * TT * TT) / (10.0 * PT * PT + TT * TT)) << " points" << endl;
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
        cout << "DominoTiling (600 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

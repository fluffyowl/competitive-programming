#include <cstdio>
#include <cmath>
#include <cstring>
#include <ctime>
#include <iostream>
#include <algorithm>
#include <set>
#include <vector>
#include <sstream>
#include <typeinfo>
#include <fstream>

using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)

const int MAX = 55;
long long dp[MAX+1][2][MAX+1][MAX+1]; // 桁, n以上か, 連続した1の数, 直前が1か

class ConsecutiveOnes {
    public:
    long long get(long long n, int k) {
        REP(a, MAX+1) REP(b, 2) REP(c, MAX+1) REP(d, MAX+1) dp[a][b][c][d] = (1L << 58) - 1;
        dp[0][0][0][0] = 0;
        REP(a, MAX) REP(b, 2) REP(c, MAX) REP(d, MAX) {
            //if (dp[a][b][c][d] == 1L << 58 - 1) continue;
            int digit;
            if (b) digit = 0;
            else if (n & (1L << (MAX-a-1))) digit = 1;
            else digit = 0;
            for (long long int e = 1; e >= digit; e--) {
                bool greater = (e == 1 && !(n & (1L << (MAX-a-1))));
                int new_d = e ? d + 1 : 0;
                int new_c = max(c, new_d);

                new_c = max(c, new_c);
                dp[a+1][b||greater][new_c][new_d] =
                    min(dp[a+1][b||greater][new_c][new_d],
                        (dp[a][b][c][d] << 1) + e);
            }
        }

        long long ans = 1L << 58;
        REP(a, 2) for (int b = k; b < MAX; b++) REP(c, MAX+1) {
                ans = min(ans, dp[MAX][a][b][c]);
            }

        return ans;
    }
};

// CUT begin
ifstream data("ConsecutiveOnes.sample");

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

bool do_test(long long n, int k, long long __expected) {
    time_t startClock = clock();
    ConsecutiveOnes *instance = new ConsecutiveOnes();
    long long __result = instance->get(n, k);
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
        long long n;
        from_stream(n);
        int k;
        from_stream(k);
        next_line();
        long long __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(n, k, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1490434715;
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
        cout << "ConsecutiveOnes (250 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

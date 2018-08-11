#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

int N;
ll D;
ll base[1010];
int mem[1010][1010];

class LeftToRightGame {
    public:
    bool dfs(int turn, ll d) {
        if (mem[turn][d] >= 0) {
            return mem[turn][d];
        }
        if (turn == N && turn % 2 == 0) {
            return d != 0;
        }
        if (turn == N && turn % 2 == 1) {
            return d == 0;
        }

        ll b = base[N - turn -1];

        if (turn % 2 == 0) {
            bool ok = false;
            for (ll digit = turn == 0 ? 1 : 0; digit < 10; ++digit) {
                if (!dfs(turn+1, (d + digit * b % D) % D)) {
                    ok = true;
                    break;
                }
            }
            mem[turn][d] = ok;
        } else {
            bool ok = false;
            for (ll digit = turn == 0 ? 1 : 0; digit < 10; ++digit) {
                if (!dfs(turn+1, (d + digit * b % D) % D)) {
                    ok = true;
                    break;
                }
            }
            mem[turn][d] = ok;
        }

        return mem[turn][d];
    }

    string whoWins(int length, int divisor) {
        REP(i, 1010) REP(j, 1010) mem[i][j] = -1;
        N = length;
        D = divisor;
        base[0] = 1;
        for (int i = 1; i < N; ++i) {
            base[i] = base[i] * 10 % D;
        }

        return dfs(0, 0) ? "Alice" : "Bob";
    }
};

// CUT begin
ifstream data("LeftToRightGame.sample");

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

bool do_test(int length, int divisor, string __expected) {
    time_t startClock = clock();
    LeftToRightGame *instance = new LeftToRightGame();
    string __result = instance->whoWins(length, divisor);
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
        int length;
        from_stream(length);
        int divisor;
        from_stream(divisor);
        next_line();
        string __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(length, divisor, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1530979203;
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
        cout << "LeftToRightGame (250 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

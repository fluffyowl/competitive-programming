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

int mem[110][110][110];
int s;

int dp(int a, int b, int c) {
    if (a < s || b < s || c < s) return 0;
    if (mem[a][b][c] >= 0) return mem[a][b][c];
    if (mem[a][c][b] >= 0) return mem[a][c][b];
    if (mem[b][a][c] >= 0) return mem[b][a][c];
    if (mem[b][c][a] >= 0) return mem[b][c][a];
    if (mem[c][a][b] >= 0) return mem[c][a][b];
    if (mem[c][b][a] >= 0) return mem[c][b][a];
    int ret = max(a*b, b*c);
    ret = max(ret, c*a);
    for (int i = s; i <= a && a-i >= s; i++) {
        ret = max(ret, dp(i, b, c) + dp(a-i, b, c));
    }
    for (int i = s; i <= b && b-i >= s; i++) {
        ret = max(ret, dp(a, i, c) + dp(a, b-i, c));
    }
    for (int i = s; i <= c && c-i >= s; i++) {
        ret = max(ret, dp(a, b, i) + dp(a, b, c-i));
    }

    return mem[a][b][c] = ret;
}

class CheeseSlicing {
public:
    int totalArea(int A, int B, int C, int S) {
        REP(i, 110) REP(j, 110) REP(k, 110) mem[i][j][k] = -1;
        s = S;
        return dp(A, B, C);
    }
};

// CUT begin
ifstream data("CheeseSlicing.sample");

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

bool do_test(int A, int B, int C, int S, int __expected) {
    time_t startClock = clock();
    CheeseSlicing *instance = new CheeseSlicing();
    int __result = instance->totalArea(A, B, C, S);
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
        int A;
        from_stream(A);
        int B;
        from_stream(B);
        int C;
        from_stream(C);
        int S;
        from_stream(S);
        next_line();
        int __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(A, B, C, S, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1491063089;
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
        cout << "CheeseSlicing (500 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

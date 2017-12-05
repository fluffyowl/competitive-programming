#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

string yes = "Possible";
string no = "Impossible";
int X[100][100]; // 0 => 0, 1 => 1, 2 => 0 or 1

class OrAndSum {
public:
    string isPossible(vector<long long> pairOr, vector<long long> pairSum) {
        memset(X, 0, sizeof(X));
        int N = pairOr.size();

        for (int i = 0; i < N; ++i)
            if (pairOr[i] > pairSum[i])
                return no;

        for (int j = 0; j < 61; ++j)
            X[0][j] = 2;

        for (int i = 0; i < N; ++i) {
            bool carry = 0;
            for (int j = 0; j < 61; ++j) {
                int a = (pairOr[i] >> j) & 1;
                int b = (pairSum[i] >> j) & 1;
                b ^= carry;
                if (a & b) {
                    if (X[i][j] == 0)
                        X[i+1][j] = 1;
                    else if (X[i][j] == 1)
                        X[i+1][j] = 0;
                    else
                        X[i+1][j] = 2;
                } else if (a) {
                    if (X[i][j] == 0)
                        return no;
                    else
                        X[i+1][j] = 1;
                    carry = 1;
                } else if (b) {
                    return no;
                } else {
                    if (X[i][j] == 1)
                        return no;
                    else
                        X[i+1][j] = 0;
                    carry = 0;
                }
            }
        }

        return yes;
    }
};

// CUT begin
ifstream data("OrAndSum.sample");

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

bool do_test(vector<long long> pairOr, vector<long long> pairSum, string __expected) {
    time_t startClock = clock();
    OrAndSum *instance = new OrAndSum();
    string __result = instance->isPossible(pairOr, pairSum);
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
        vector<long long> pairOr;
        from_stream(pairOr);
        vector<long long> pairSum;
        from_stream(pairSum);
        next_line();
        string __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(pairOr, pairSum, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1511884802;
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
        cout << "OrAndSum (250 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

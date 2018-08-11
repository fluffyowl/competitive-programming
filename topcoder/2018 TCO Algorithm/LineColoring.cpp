#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

class LineColoring {
    public:
    int minCost(vector<int> x) {
        int N = x.size();

        int mx[2] = {0, 0};
        REP(i ,N) mx[i%2] = max(mx[i%2], x[i]);
        int m = max(mx[0], mx[1]);
        int ans = mx[0] + mx[1];

        REP(i, N-1) if (x[i] == x[i+1] && x[i] == m)
            return ans;


        vector<int> y;
        REP(i, N) if (x[i] == m) y.push_back(i);

        int b = 0;
        int c = 0;

        REP(i, (int)y.size()-1) {
            int l = y[i]+1;
            int r = y[i+1];
            if (l == r ) {
                continue;
            } else if (l + 1 == r) {
                b = max(b, x[l]);
                continue;
            } else if (l + 2 == r) {
                b = max(b, max(x[l], x[l+1]));
                c = max(c, min(x[l], x[l+1]));
            }
            int mn = 1 << 29;
            REP2(j, l+1, r-2) {
                b = max(b, min(x[j], x[j+1]));
            }
            REP2(j, l, r) {
                mn = min(mn, x[j]);
            }
            c = max(c, mn);
        }

        ans = min(ans, m + b + c);

        return 0;
    }
};

// CUT begin
ifstream data("LineColoring.sample");

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

bool do_test(vector<int> x, int __expected) {
    time_t startClock = clock();
    LineColoring *instance = new LineColoring();
    int __result = instance->minCost(x);
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
        vector<int> x;
        from_stream(x);
        next_line();
        int __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(x, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1528991491;
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
        cout << "LineColoring (500 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

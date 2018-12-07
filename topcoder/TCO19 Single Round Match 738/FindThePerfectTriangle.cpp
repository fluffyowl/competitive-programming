#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

const int MAX = 3001;
const int HOGE = MAX*MAX*2*2;
int sq[HOGE];
int X[20000];
int Y[20000];
int L[20000];

class FindThePerfectTriangle {
    public:
    vector<int> constructTriangle(int area, int perimeter) {
        for (int i = 0; i * i < HOGE; ++i) {
            sq[i * i] = i;
        }

        int cnt = 0;

        REP(x, MAX) REP(y, MAX) {
            int lensq = x * x + y * y;
            if (sq[lensq] == 0) continue;
            X[cnt] = x;
            Y[cnt] = y;
            L[cnt] = sq[lensq];
            ++cnt;
        }

        REP(i, cnt) REP(j, cnt) if (i != j && X[i] <= Y[i]) {
            int lensq = (X[i] - X[j]) * (X[i] - X[j]) + (Y[i] - Y[j]) * (Y[i] - Y[j]);
            if (sq[lensq] == 0 || perimeter != L[i] + L[j] + sq[lensq]) continue;
            int a = abs(X[i] * Y[j] - Y[i] * X[j]);
            if (a != 2 * area) continue;
            return {0, 0, X[i], Y[i], X[j], Y[j]};
        }

        return vector<int>();
    }
};

// CUT begin
ifstream data("FindThePerfectTriangle.sample");

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

template <typename T> string to_string(vector<T> ts) {
    stringstream s;
    s << "[ ";
    for (int i = 0; i < ts.size(); ++i) {
        if (i > 0) s << ", ";
        s << to_string(ts[i]);
    }
    s << " ]";
    return s.str();
}

bool do_test(int area, int perimeter, vector<int> __expected) {
    time_t startClock = clock();
    FindThePerfectTriangle *instance = new FindThePerfectTriangle();
    vector<int> __result = instance->constructTriangle(area, perimeter);
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
        int area;
        from_stream(area);
        int perimeter;
        from_stream(perimeter);
        next_line();
        vector<int> __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(area, perimeter, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1538326803;
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
        cout << "FindThePerfectTriangle (250 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

#include <bits/stdc++.h>
using namespace std;

class ModEquationEasy {
    public:
    int n, K, v;
    int mod = 1000000007;
    int[101] comb;

    void enumerate_comb() {
        for (int i = 0; i < n; i ++) {
            for (int j = 0; j < n; j++) {
                comb[i*j%K]++;
            }
        }
    }

    int count(int n, int K, int v) {
        this.n = n;
        this.K = K;
        this.v = v;
        enumerate_comb();
        return 0;
    }

    int rec(int x, int y) {
        int ret;
        if (x > 2) {
            for (int i = 0; i < n; i++)
                ret = (ret + rec(n/2, ))
            return (rec(n/2) + rec(n/2+n%2)) % mod;
        }
        else if (n == 2) {
            return comb[v] % mod;
        }
        else if (n == 1)
    }
};

// CUT begin
ifstream data("ModEquationEasy.sample");

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

bool do_test(int n, int K, int v, int __expected) {
    time_t startClock = clock();
    ModEquationEasy *instance = new ModEquationEasy();
    int __result = instance->count(n, K, v);
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
        int n;
        from_stream(n);
        int K;
        from_stream(K);
        int v;
        from_stream(v);
        next_line();
        int __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(n, K, v, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1483014591;
        double PT = T / 60.0, TT = 75.0;
        cout << "Time   : " << T / 60 << " minutes " << T % 60 << " secs" << endl;
        cout << "Score  : " << 900 * (0.3 + (0.7 * TT * TT) / (10.0 * PT * PT + TT * TT)) << " points" << endl;
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
        cout << "ModEquationEasy (900 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

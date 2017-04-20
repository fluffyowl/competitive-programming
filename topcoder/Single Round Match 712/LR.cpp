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
#include <numeric>

using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
const string no = "No solution";


class LR {
    public:
    string construct(vector<long long> s, vector<long long> t) {
        int N = s.size();
        long long ss = 0;
        long long ts = 0;
        REP(i, N) ss += s[i], ts += t[i];
        if (ss == 0 && ts == 0) return "";
        if (ss == 0) return no;
        if (ts < ss) return no;
        if (ss == ts) {
            REP(i, N) if (s[i] != t[i]) return no;
            return "";
        }

        long q = ts / ss;
        if (q & (q-1)) return no;
        REP(i, N) if (s[i] > t[i]) return no;

        long p = 0;
        while (q > 1) q /= 2, p += 1;

       REP(left, p+1) {
            int right = p - left;
            vector<long long> u(N);
            vector<long long> oldu(N);
            REP(i, N) u[i] = oldu[i] = s[i];
            REP(i, left) {
                REP(j, N) u[j] += oldu[(j+1)%N];
                REP(j, N) oldu[j] = u[j];
            }
            REP(i, right) {
                REP(j, N) u[j] += oldu[(j-1+N)%N];
                REP(j, N) oldu[j] = u[j];
            }

            bool ok = true;
            REP(i, N) if (t[i] != u[i]) {
                ok = false;
                break;
            }

            if (ok) {
                string ans = "";
                REP(i, left) ans += "L";
                REP(i, right) ans += "R";
                return ans;
            }
        }


        return no;
    }
};

// CUT begin
ifstream data("LR.sample");

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

bool do_test(vector<long long> s, vector<long long> t, string __expected) {
    time_t startClock = clock();
    LR *instance = new LR();
    string __result = instance->construct(s, t);
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
        vector<long long> s;
        from_stream(s);
        vector<long long> t;
        from_stream(t);
        next_line();
        string __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(s, t, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1492513203;
        double PT = T / 60.0, TT = 75.0;
        cout << "Time   : " << T / 60 << " minutes " << T % 60 << " secs" << endl;
        cout << "Score  : " << 300 * (0.3 + (0.7 * TT * TT) / (10.0 * PT * PT + TT * TT)) << " points" << endl;
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
        cout << "LR (300 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

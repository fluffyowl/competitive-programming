#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

int cnt[9];
int tmp[9];

class Avoid9 {
    public:
    int maxSizeOf9Free(vector<int> A) {
        int N = A.size();
        memset(cnt, 0, sizeof(cnt));
        memset(tmp, 0, sizeof(tmp));
        REP(i, N) cnt[A[i] % 9] += 1;
        cnt[3] = min(cnt[3], 2);
        cnt[6] = min(cnt[6], 2);
        cnt[0] = min(cnt[0], 2);
        int ans = 0;

        REP(m, 19683) {
            int mask = m;
            REP(i, 9) {
                int x = mask % 3;
                mask /= 3;
                tmp[i] = x <= 1 ? min(x, cnt[i]) : cnt[i];
            }

            bool ok = true;
            REP(i, 9) REP(j, 9) REP(k, 9) if ((i + j + k) % 9 == 0) {
                tmp[i] -= 1;
                tmp[j] -= 1;
                tmp[k] -= 1;
                if (tmp[i] < 0 || tmp[j] < 0 || tmp[k] < 0) {
                    tmp[i] += 1;
                    tmp[j] += 1;
                    tmp[k] += 1;
                    continue;
                }

                ok = false;

                tmp[i] += 1;
                tmp[j] += 1;
                tmp[k] += 1;
            }

            int hoge = 0;
            if (ok) {REP(i, 9) hoge += tmp[i]; ans = max(ans, hoge);}
        }

        return ans < 3 ? -1 : ans;
    }
};

// CUT begin
ifstream data("Avoid9.sample");

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

bool do_test(vector<int> A, int __expected) {
    time_t startClock = clock();
    Avoid9 *instance = new Avoid9();
    int __result = instance->maxSizeOf9Free(A);
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
        vector<int> A;
        from_stream(A);
        next_line();
        int __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(A, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1504897364;
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
        cout << "Avoid9 (600 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

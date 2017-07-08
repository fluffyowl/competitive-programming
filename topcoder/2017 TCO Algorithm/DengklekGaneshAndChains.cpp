#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

int mx[100];
string ms[100];
bool used[100];

class DengklekGaneshAndChains {
    public:
    string getBestChains(vector<string> chains, vector<int> lengths) {
        int N = chains.size();
        int K = chains[0].length();
        int M = lengths.size();
        memset(used, 0, sizeof(used));
        REP(i, N) chains[i] += chains[i];

        REP(i, N) {
            string hoge = "11111111111111111111111111111111111111111111";
            int mj = -1;
            REP(j, K) {
                string tmp = chains[i].substr(j, K);
                if (tmp >= hoge) {
                    hoge = tmp;
                    mj = j;
                }
            }
            mx[i] = mj;
            ms[i] = hoge;
        }

        string ans = "";

        REP(m, M) {
            string tmpmax = "1";
            REP(i, lengths[m]) tmpmax += "1";
            int mi = -1;
            REP(i, N) if (!used[i]) {
                string tmp = ms[i].substr(0, lengths[m]);
                if (tmp > tmpmax) {
                    tmpmax = tmp;
                    mi = i;
                } else if (mi != -1 && tmp == tmpmax && ms[i] < ms[mi]) {
                    tmpmax = tmp;
                    mi = i;
                }
            }
            used[mi] = true;
            ans += ms[mi].substr(0, lengths[m]);
        }

        return ans;
    }
};

// CUT begin
ifstream data("DengklekGaneshAndChains.sample");

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

bool do_test(vector<string> chains, vector<int> lengths, string __expected) {
    time_t startClock = clock();
    DengklekGaneshAndChains *instance = new DengklekGaneshAndChains();
    string __result = instance->getBestChains(chains, lengths);
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
        vector<string> chains;
        from_stream(chains);
        vector<int> lengths;
        from_stream(lengths);
        next_line();
        string __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(chains, lengths, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1499529604;
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
        cout << "DengklekGaneshAndChains (300 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

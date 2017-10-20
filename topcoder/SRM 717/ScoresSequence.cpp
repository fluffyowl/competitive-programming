#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

const int INF = 1 << 29;

class ScoresSequence {
    public:
    int count(vector<int> s) {
        int N = s.size();
        vector<int> in(N, 0);
        REP(i, N) in[i] = N - 1 - s[i];
        vector<vector<int>> edges(N, vector<int>(N, 0));
        vector<bool> used(N, false);

        REP(i, N) {
            int from = -1, maxv = -1;

            REP(j, N) if (!used[j] && s[j] > maxv) {
                from = j;
                maxv = s[j];
            }
            used[from] = true;


            vector<pair<int, int>> vp;
            REP(j, N) if (!used[j]) vp.push_back(make_pair(s[j], j));
            sort(vp.begin(), vp.end());

            REP(j, N - i - 1) {
                int to = vp[j].second;
                if (in[to] > 0 && s[from] > 0) {
                    in[to]--;
                    s[from]--;
                    edges[from][to] = 1;
                    edges[to][from] = INF;
                } else {
                    in[from]--;
                    s[to]--;
                    edges[from][to] = INF;
                    edges[to][from] = 1;
                }
            }
        }


        REP(i, N) REP(j, N) REP(k, N) {
            edges[j][k] = min(edges[j][k], edges[j][i] + edges[i][k]);
        }

        int ans = 0;
        REP(i, N) REP(j, N) ans += edges[i][j] < INF;

        return ans;
    }
};

// CUT begin
ifstream data("ScoresSequence.sample");

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

bool do_test(vector<int> s, int __expected) {
    time_t startClock = clock();
    ScoresSequence *instance = new ScoresSequence();
    int __result = instance->count(s);
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
        vector<int> s;
        from_stream(s);
        next_line();
        int __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(s, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1501436348;
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
        cout << "ScoresSequence (250 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

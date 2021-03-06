#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

vector<int> edges[100];
bool cut[100][100];
int root;
int ans = 0;

int dfs2(int n, int p) {
    int cnt = 0;
    for (auto m: edges[n]) {
        if (!cut[n][m]) cnt++;
    }
    if (cnt <= 1) return n;
    for (auto m: edges[n]) {
        if (m != p && !cut[m][n]) return dfs2(m, n);
    }
    return -1;
}

void dfs(int n, bool cutcut) {
    if (cutcut) n = dfs2(n, -1);

    int cnt = 0;
    for (auto m: edges[n]) {
        if (!cut[n][m]) cnt++;
    }

    ans += max(0, cnt - 1);

    for (auto m: edges[n]) {
        if (!cut[n][m]) {
            cut[n][m] = cut[m][n] = true;
            dfs(m, cnt >= 2);
        }
    }
}


class TransformTheTree {
    public:
    int countCuts(vector<int> parents) {
        int N = parents.size() + 1;
        REP(i, N - 1) {
            edges[i + 1].push_back(parents[i]);
            edges[parents[i]].push_back(i + 1);
        }

        REP(i, N) REP(j, N) cut[i][j] = false;

        REP(i, N) {
            if ((int)edges[i].size() == 1) {
                root = i;
                break;
            }
        }

        dfs(root, false);
        return ans;
    }
};

// CUT begin
ifstream data("TransformTheTree.sample");

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

bool do_test(vector<int> parents, int __expected) {
    time_t startClock = clock();
    TransformTheTree *instance = new TransformTheTree();
    int __result = instance->countCuts(parents);
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
        vector<int> parents;
        from_stream(parents);
        next_line();
        int __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(parents, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1501344263;
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
        cout << "TransformTheTree (600 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

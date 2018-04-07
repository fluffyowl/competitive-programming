#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

class StonesOnATree {
    public:
    int N;
    vector<int> W;
    vector<vector<int> > G;
    vector<int> M;
    int ans = 0;

    int dfs(int n) {
        for (auto m: G[n]) M[n] = max(M[n], dfs(m));
        return M[n];
    }

    int dfs2(int n) {
        int ret = 0;
        if (G[n].size() == 0) {
            ret = W[n];
        } else if (G[n].size() == 1) {
            ret = W[n] + W[G[n][0]];
            ret = max(ret, dfs2(G[n][0]));
        } else {
            int a = G[n][0];
            int b = G[n][1];
            int a_first = 0;
            int b_first = 0;

            a_first = W[a] + M[b];
            a_first = max(a_first, dfs2(a));
            a_first = max(a_first, W[a] + dfs2(b));

            b_first = W[b] + M[a];
            b_first = max(b_first, dfs2(b));
            b_first = max(b_first, W[b] + dfs2(a));

            ret = W[n] + W[a] + W[b];
            ret = max(ret, min(a_first, b_first));
        }
        return ret;
    }

    int minStones(vector<int> p, vector<int> w) {
        W = w;
        N = w.size();
        M = vector<int>(N, 0);
        G = vector<vector<int> >(N, vector<int>());

        REP(i, N-1) {
            G[p[i]].push_back(i+1);
        }

        REP(i, N) {
            M[i] = W[i];
            for (auto m: G[i]) M[i] += W[m];
        }

        dfs(0);
        return dfs2(0);
    }
};

// CUT begin
ifstream data("StonesOnATree.sample");

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

bool do_test(vector<int> p, vector<int> w, int __expected) {
    time_t startClock = clock();
    StonesOnATree *instance = new StonesOnATree();
    int __result = instance->minStones(p, w);
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
        vector<int> p;
        from_stream(p);
        vector<int> w;
        from_stream(w);
        next_line();
        int __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(p, w, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1519128007;
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
        cout << "StonesOnATree (250 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

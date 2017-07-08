#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)


int N;
vector<int> edges[2010];
int depth[2010];
int dp[20][2010];
vector<pair<int, int>> dist[2010];
bool okdist[2010];
bool ok[2010];
bool used[2010];
bool uuuu[2010];

void dfs(int n, int p, int d) {
    //if (uuuu[n]) return;
    uuuu[n] = true;
    dp[0][n] = p;
    depth[n] = d;
    for (auto m: edges[n]) {
        if (m != p) {
            if (d < 15) cout << n << " " << p << " " << m << endl;
            dfs(m, n, d + 1);
        }
    }
}

int lca(int a, int b) {
    if (depth[a] < depth[b])
        swap(a, b);
    int orig_a = a;
    int orig_b = b;
    while (depth[a] > depth[b]){
        int K = 19;
        for (int k = K; k >= 0; k--) {
            if ((1 << k) <= depth[a] - depth[b]) {
                a = dp[k][a];
                K = k;
            }
        }
    }

    if (a == b)
        return a;
        //return max(depth[orig_a]-depth[b], depth[orig_b]-depth[a])+1;

    while (dp[0][a] != dp[0][b]) {
        int K = 19;
        for (int k = K; k >= 0; k--) {
            if (dp[k][a] != dp[k][b]) {
                a = dp[k][a];
                b = dp[k][b];
                K = k;
            }
        }
    }

    return dp[0][a];
    //return depth[orig_a] + depth[orig_b]  - 2*depth[dp[0][a]] + 1;
}


class JumpDistancesOnTree {
    public:
    string isPossible(vector<int> p, vector<int> S) {
        N = p.size() + 1;

        REP(i, N-1) {
            edges[i+1].push_back(p[i]);
            edges[p[i]].push_back(i+1);
            cout << i+1 << " " << p[i] << endl;
            cout << p[i] << " " << i+1 << endl;
        }

        REP(i, N) for (auto m: edges[i]) cout << "e: " << i << " " << m << endl;

        REP(i, 2005) ok[i] = false;
        REP(i, 2005) okdist[i] = false;
        for (auto s: S) okdist[s] = true;

        memset(depth, 0, sizeof(depth));
        memset(dp, 0, sizeof(dp));
        memset(uuuu, 0, sizeof(uuuu));

        dfs(0, -1, 0);
        REP(k, 19) REP(n, N)
            dp[k+1][n] = (dp[k][n] == -1) ? -1 : dp[k][dp[k][n]];

        REP(i, N) REP2(j, i+1, N) {
            int a = lca(i, j);
            int d = depth[i] + depth[j] - depth[a] * 2;
            if (!okdist[d]) continue;
            dist[i].push_back(make_pair(j, d));
            dist[j].push_back(make_pair(i, d));
        }

        REP(i, 2005) used[i] = false;

        deque<int> deq;
        deq.push_back(0);
        while (!deq.empty()) {
            int n = deq.front();
            deq.pop_front();
            if (used[n]) continue;
            used[n] = true;
            for (auto p: dist[n]) {
                if (!okdist[p.second]) continue;
                ok[p.second] = true;
                if (!used[p.first]) deq.push_back(p.first);
            }
        }

        if (okdist[0]) ok[0] = true;
        bool ans = true;
        for (auto s: S) if (!ok[s]) ans = false;

        return ans ? "Possible" : "Impossible";
    }
};

// CUT begin
ifstream data("JumpDistancesOnTree.sample");

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

bool do_test(vector<int> p, vector<int> S, string __expected) {
    time_t startClock = clock();
    JumpDistancesOnTree *instance = new JumpDistancesOnTree();
    string __result = instance->isPossible(p, S);
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
        vector<int> S;
        from_stream(S);
        next_line();
        string __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(p, S, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1498527069;
        double PT = T / 60.0, TT = 75.0;
        cout << "Time   : " << T / 60 << " minutes " << T % 60 << " secs" << endl;
        cout << "Score  : " << 450 * (0.3 + (0.7 * TT * TT) / (10.0 * PT * PT + TT * TT)) << " points" << endl;
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
        cout << "JumpDistancesOnTree (450 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

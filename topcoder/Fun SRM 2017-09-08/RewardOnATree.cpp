#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

int max_d;
vector<vector<int>> edges;
vector<vector<int>> depth;
vector<int> dd;

void dfs(int n, int p, int d) {
    dd[n] = d;
    max_d = max(d, max_d);
    depth[d].push_back(n);
    for (auto m: edges[n]) if (m != p) dfs(m, n, d + 1);
}

class RewardOnATree {
    public:
    int collect(vector<int> parent, vector<int> reward) {
        int N = parent.size() + 1;
        edges = vector<vector<int>>(N);
        REP(i, N-1) {
            edges[parent[i]].push_back(i + 1);
            edges[i + 1].push_back(parent[i]);
        }

        dd = vector<int>(N, 0);
        depth = vector<vector<int>>(N + 1);
        max_d = 0;
        dfs(0, -1, 0);

        int ans = - (1 << 29);
        int tmp = 0;

        REP(d, max_d + 1) {
            int next =  - (1 << 29);
            int mm = -1;

            for (auto n: depth[d]) {
                if (reward[n] >= 0 || n == 0) tmp += reward[n];
                int nx = n == 0 ? 0 : min(0, reward[n]);
                for (auto m: edges[n])
                    if (dd[m] == d + 1 && nx + min(0, reward[m]) > next)
                        next = nx + min(0, reward[m]), mm = m;
            }

            ans = max(ans, tmp);
            tmp += next;
            if (mm != -1)
                reward[mm] = max(0, reward[mm]);
        }

        return ans;
    }
};

// CUT begin
ifstream data("RewardOnATree.sample");

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

bool do_test(vector<int> parent, vector<int> reward, int __expected) {
    time_t startClock = clock();
    RewardOnATree *instance = new RewardOnATree();
    int __result = instance->collect(parent, reward);
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
        vector<int> parent;
        from_stream(parent);
        vector<int> reward;
        from_stream(reward);
        next_line();
        int __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(parent, reward, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1504899827;
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
        cout << "RewardOnATree (900 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

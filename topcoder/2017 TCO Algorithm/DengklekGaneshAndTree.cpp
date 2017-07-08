#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

const ll MOD = 1000000007;
vector<int> edges[1010];
string LS;
int dpeth[1010];
ll ans = 0;
vector<int> ddd[1010];

bool same_ins(char c1, char c2) {
    if (c1 - 32 == c2) return true;
    if (c1 == c2 - 32) return true;
    return false;
}

void dfs1(int n, int p, int d) {
    depth[n] = d;
    for (auto m: edges[n]) if (m != p) dfs1(m, n, d+1);
}

ll dfs(int n, int p, int pcpc) {
    int ncnc;
    ll ret = 0;
    if (n == 0) ncnc = 0, ret = 1;
    else if (pcpc == 0 && LS[p] == LS[n]) ncnc = 0, ret = 1;
    else if (pcpc == 1 && LS[p] == LS[n]) ncnc = 1, ret = 1;
    else if (pcpc == 2 && LS[p] == LS[n]) ncnc = 2, ret = 1;
    else ncnc = 2, ret = 2;

    for (auto m: edges[n]) {
        if (m == p) continue;
        ret = ret * dfs(m, n, pcpc) % MOD;
    }



    return ret;
}


class DengklekGaneshAndTree {
    public:
    int getCount(string labels, vector<int> parents) {
        LS = labels;
        REP(i, N) {
            edges[parents[i]].push_back(i+1);
            edges[i+1].push_back(parents[i]);
        }
        dfs1(0, -1, 0);
        dfs(0, -1, -1);

        REP(i, N) {
            ddd[depth[i]].push_back(i);
        }



        return 0;
    }
};

// CUT begin
ifstream data("DengklekGaneshAndTree.sample");

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

bool do_test(string labels, vector<int> parents, int __expected) {
    time_t startClock = clock();
    DengklekGaneshAndTree *instance = new DengklekGaneshAndTree();
    int __result = instance->getCount(labels, parents);
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
        string labels;
        from_stream(labels);
        vector<int> parents;
        from_stream(parents);
        next_line();
        int __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(labels, parents, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1499532152;
        double PT = T / 60.0, TT = 75.0;
        cout << "Time   : " << T / 60 << " minutes " << T % 60 << " secs" << endl;
        cout << "Score  : " << 500 * (0.3 + (0.7 * TT * TT) / (10.0 * PT * PT + TT * TT)) << " points" << endl;
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
        cout << "DengklekGaneshAndTree (500 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

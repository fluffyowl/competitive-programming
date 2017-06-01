#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)


const int MAX = 50;
const int INF = 1 << 29;
int N;
vector<int> backet0[MAX + 1];
vector<int> backet1[MAX + 1];
vector<pair<int, int> > d0;
vector<pair<int, int> > d1;
vector<int> dist11;
int dist[MAX + 1][MAX + 1];

bool dfs(int n) {
    if (n == N) {
        REP(i, N) REP(j, N) REP(k, N)
            dist[j][k] = min(dist[j][k], dist[j][i] + dist[i][k]);
        REP(i, N)
            if (dist[1][i] < dist11[i])
                return false;
        return true;
    }

    int d = d0[n].first;
    int ind = d0[n].second;
    REP(i, backet0[d-1].size()) {
        dist[ind][backet0[d-1][i]] = dist[backet0[d-1][i]][ind] = 1;
        bool ret = dfs(n + 1);
        if (ret)
            return true;
        dist[ind][backet0[d-1][i]] = dist[backet0[d-1][i]][ind] = INF;
    }

    return false;
}

class DistanceZeroAndOne {
    public:
    vector<string> construct(vector<int> dist0, vector<int> dist1) {
        N = dist0.size();
        REP(i, N) {
            if (i == 0 && dist0[i] != 0)
                return vector<string>();
            if (i == 1 && dist1[i] != 1)
                return vector<string>();
            if (i != 0 && dist0[i] == 0)
                return vector<string>();
            if (i != 1 && dist0[i] == 0)
                return vector<string>();
            d0.push_back(make_pair(dist0[i], i));
            d1.push_back(make_pair(dist1[i], i));
            backet0[dist0[i]].push_back(i);
            backet1[dist1[i]].push_back(i);
        }

        sort(d0.begin(), d0.end());
        sort(d1.begin(), d1.end());

        REP(i, N-1) {
            if (d0[i+1].first - d0[i].first > 1)
                return vector<string>();
            if (d1[i+1].first - d1[i].first > 1)
                return vector<string>();
        }

        REP(i, N) dist11.push_back(dist1[i]);
        REP(i, N) dist[i][i] = INF;

        bool possible = dfs(1);
        if (possible) {

        }
        else
            return vector<string>();
    }
};

// CUT begin
ifstream data("DistanceZeroAndOne.sample");

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

template <typename T> string to_string(vector<T> ts) {
    stringstream s;
    s << "[ ";
    for (int i = 0; i < ts.size(); ++i) {
        if (i > 0) s << ", ";
        s << to_string(ts[i]);
    }
    s << " ]";
    return s.str();
}

bool do_test(vector<int> dist0, vector<int> dist1, vector<string> __expected) {
    time_t startClock = clock();
    DistanceZeroAndOne *instance = new DistanceZeroAndOne();
    vector<string> __result = instance->construct(dist0, dist1);
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
        vector<int> dist0;
        from_stream(dist0);
        vector<int> dist1;
        from_stream(dist1);
        next_line();
        vector<string> __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(dist0, dist1, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1495297275;
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
        cout << "DistanceZeroAndOne (500 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

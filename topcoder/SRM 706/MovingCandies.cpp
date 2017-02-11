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

using namespace std;

class MovingCandies {
    public:
    int minMoved(vector<string> t) {
        int H = t.size();
        int W = t[0].size();
        int cnt = 0;
        for (int i = 0; i < H; i++)
            for (int j = 0; j < W; j++)
                if (t[i][j] == '#')
                    cnt++;
        if (cnt < H + W - 1)
            return -1;

        int INF = 1 << 30;
        int dx[4] = {0, 0, 1, -1};
        int dy[4] = {1, -1, 0, 0};
        int dp[1000][20][20];
        for (int k = 0; k < 1000; k++)
            for (int i = 0; i < H; i++)
                for (int j = 0; j < W; j++)
                    dp[k][i][j] = INF;
        dp[0][0][0] = (t[0][0] == '#') ? 0 : 1;

        for (int k = 1; k < cnt; k++) {
            for (int i = 0; i < H; i++) {
                for (int j = 0; j < W; j++) {
                    dp[k][i][j] = min(dp[k][i][j], dp[k-1][i][j]);
                    for (int d = 0; d < 4; d++) {
                        int ni = i + dx[d];
                        int nj = j + dy[d];
                        if (ni < 0 || ni >= H || nj < 0 || nj >= W)
                            continue;
                        int p = (t[ni][nj] == '#') ? 0 : 1;
                        dp[k][ni][nj] = min(dp[k][ni][nj], dp[k-1][i][j] + p);
                        dp[k][ni][nj] = min(dp[k][ni][nj], dp[k-1][ni][nj]);
                    }
                }
            }
        }

        int ans = INF;
        for (int k = 0; k < cnt; k++) {
            ans = min(ans, dp[k][H-1][W-1]);
            //cout << dp[k][H-1][W-1] << endl;;
        }
        cout << dp[cnt-1][0][0] << endl;
        cout << dp[cnt-1][1][0] << endl;
        cout << dp[cnt-1][0][1] << endl;
        return ans;
    }

};

// CUT begin
ifstream data("MovingCandies.sample");

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

bool do_test(vector<string> t, int __expected) {
    time_t startClock = clock();
    MovingCandies *instance = new MovingCandies();
    int __result = instance->minMoved(t);
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
        vector<string> t;
        from_stream(t);
        next_line();
        int __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(t, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1485014403;
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
        cout << "MovingCandies (250 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

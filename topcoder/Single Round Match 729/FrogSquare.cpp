#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

bool from_s[1010][1010];
bool from_t[1010][1010];
bool used[1010][1010];

int dist(int x1, int y1, int x2, int y2) {
    return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
}

class FrogSquare {
    public:
    int minimalJumps(int N, int D, int sx, int sy, int tx, int ty) {
        memset(from_s, 0, sizeof(from_s));
        memset(from_t, 0, sizeof(from_t));
        memset(used, 0, sizeof(used));

        D = D * D;

        if (sx == tx && sy == ty) return 0;
        if (dist(sx, sy, tx, ty) >= D) return 1;

        deque<tuple<int, int, int>> q;
        q.push_back(make_tuple(sx, sy, 0));

        while (!q.empty()) {
            int x, y, d;
            tie(x, y, d) = q.front();
            q.pop_front();
            if (used[x][y]) continue;
            used[x][y] = true;

            if (dist(x, y, tx, ty) >= D) return d + 1;

            REP(i, 2) REP(j, 2) {
                int nx = i * (N-1);
                int ny = j * (N-1);
                if (!used[nx][ny] && dist(x, y, nx, ny) >= D) q.push_back(make_tuple(nx, ny, d+1));
            }
        }


        return -1;
    }
};

// CUT begin
ifstream data("FrogSquare.sample");

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

template <typename T>
string to_string(T t) {
    stringstream s;
    s << t;
    return s.str();
}

string to_string(string t) {
    return "\"" + t + "\"";
}

bool do_test(int n, int d, int sx, int sy, int tx, int ty, int __expected) {
    time_t startClock = clock();
    FrogSquare *instance = new FrogSquare();
    int __result = instance->minimalJumps(n, d, sx, sy, tx, ty);
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
        int n;
        from_stream(n);
        int d;
        from_stream(d);
        int sx;
        from_stream(sx);
        int sy;
        from_stream(sy);
        int tx;
        from_stream(tx);
        int ty;
        from_stream(ty);
        next_line();
        int __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(n, d, sx, sy, tx, ty, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1518282336;
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
        cout << "FrogSquare (450 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

class SquareCutout {
    public:
    int verify(vector<string> cutout) {
        int H = cutout.size();
        int W = cutout[0].size();

        int r = -1, c = -1;
        REP(i, H) {
            bool ok = false;
            REP(j, W) if (cutout[i][j] == '#') {
                r = i;
                c = j;
                ok = true;
                break;
            }
            if (ok) break;
        }
        if (r == -1) {
            return 1;
        }


        int width = 0;

        REP2(j, c, W) {
            if (cutout[r][j] == '.') {
                break;
            }
            width += 1;
        }


        int height = 1;

        REP2(i, r+1, H) {
            int cnt = 0;
            REP2(j, c, c+width) {
                cnt += cutout[i][j] == '#';
            }
            if (cnt == 0) {
                break;
            } else if (cnt == width) {
                height += 1;
            } else {
                return 0;
            }
        }

        int up = r;
        int down = r + height - 1;
        int left = c;
        int right = c + width - 1;

        REP(i, H) REP(j, W) if (cutout[i][j] == '#' && (i < up || i > down || j < left || j > right)) {
            return 0;
        }

        if (height == width) {
            return height;
        }

        if ((up == 0 && left == 0) || (up == 0 && right == W-1) || (down == H-1 && left == 0) || (down == H-1 && right == W-1)) {
            return max(height, width);
        }

        if ((up == 0 && height <= width) || (down == H-1 && height <= width)) {
            return width;
        }

        if ((left == 0 && width <= height) || (right == W-1 && width <= height)) {
            return height;
        }

        return 0;
    }
};

// CUT begin
ifstream data("SquareCutout.sample");

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

bool do_test(vector<string> cutout, int __expected) {
    time_t startClock = clock();
    SquareCutout *instance = new SquareCutout();
    int __result = instance->verify(cutout);
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
        vector<string> cutout;
        from_stream(cutout);
        next_line();
        int __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(cutout, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1532048405;
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
        cout << "SquareCutout (250 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

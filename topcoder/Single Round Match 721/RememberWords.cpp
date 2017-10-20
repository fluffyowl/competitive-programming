#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

const string yes = "Possible";
const string no  = "Impossible";
const ll INF = 1LL << 59;
const ll MAX = 1000000000;

ll sm(ll a, ll d) {
    return d * (2 * a + d - 1) / 2;
}

ll binsearch_max(ll d, ll w) {
    ll hi = MAX + 1;
    ll lo = 0;

    while (hi - lo > 1) {
        ll mid = (hi + lo) / 2;
        ll s = sm(mid, d);
        if (s <= w) lo = mid;
        else hi = mid;
    }

    return lo;
}

ll binsearch_min(ll d, ll w) {
    ll hi = MAX;
    ll lo = -1;

    while (hi - lo > 1) {
        ll mid = (hi + lo) / 2;
        ll s = sm(mid, d);
        if (s >= w) hi = mid;
        else lo = mid;
    }

    return hi;
}

ll binsearch_maxmin(ll d, ll w) {
    ll hi = d;
    ll lo = -1;
    while (hi - lo > 1) {
        ll mid = (hi + lo) / 2;
        ll s = mid * (mid - 1) / 2;
        if (s >= w) hi = mid;
        else lo = mid;
    }

    return hi;
}

class RememberWords {
    public:
    string isPossible(int d1, int d2, int w1, int w2) {
        ll d1max, d1min, d2max, d2min;

        d1max = binsearch_max(d1, w1);
        d2max = binsearch_max(d2, w2);
        d1min = binsearch_min(d1, w1);
        d2min = binsearch_min(d2, w2);

        d1max = d1max == 0 ? binsearch_maxmin(d1, w1) : d1max + d1 - 1;
        d2max = d2max == 0 ? binsearch_maxmin(d2, w2) : d2max + d2 - 1;

        if (d1min - 1 > d2max || d1max + 1 < d2min)
            return no;
        else
            return yes;
    }
};

// CUT begin
ifstream data("RememberWords.sample");

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

bool do_test(int d1, int d2, int w1, int w2, string __expected) {
    time_t startClock = clock();
    RememberWords *instance = new RememberWords();
    string __result = instance->isPossible(d1, d2, w1, w2);
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
        int d1;
        from_stream(d1);
        int d2;
        from_stream(d2);
        int w1;
        from_stream(w1);
        int w2;
        from_stream(w2);
        next_line();
        string __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(d1, d2, w1, w2, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1506438004;
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
        cout << "RememberWords (250 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

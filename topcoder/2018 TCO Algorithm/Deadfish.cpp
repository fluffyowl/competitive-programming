#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

const ll MAX = 800000;
const ll INF = 1 << 29;
ll dist[MAX*2+100];

class Deadfish {
    public:
    int shortestCode(ll N) {
        memset(dist, 0, sizeof(dist));
        REP(i, MAX*2+100) dist[i] = INF;
        priority_queue<pair<ll, ll> > q;
        q.push(make_pair(0, MAX));

        while (!q.empty()) {
            auto t = q.top();
            ll d = -t.first;
            ll n = t.second - MAX;
            q.pop();
            if (dist[n] <= d) continue;
            dist[n] = d;

            if (n + 1 <= MAX) {
                if (dist[n+1+MAX] <= d + 1) continue;
                q.push(make_pair(-(d+1), n+1+MAX));
            }

            if (n - 1 >= -MAX) {
                if (dist[n-1+MAX] <= d + 1) continue;
                q.push(make_pair(-(d+1), n-1+MAX));
            }

            if (n * n <= MAX) {
                if (dist[n*n] <= d + 1) continue;
                q.push(make_pair(-(d+1), n*n+MAX));
            }

            ll nn = abs(n);
            vector<ll> hoge;
            while (nn > 0) {
                hoge.push_back(nn%10);
                nn /= 10;
            }
            sort(hoge.rbegin(), hoge.rend());

            nn = 0;
            for (int i = 0; i < hoge.size(); ++i) {
                nn *= 10;
                nn += hoge[i];
            }

            if (n < 0) nn *= -1;

            if (nn >= -MAX && nn <= MAX) {
                if (dist[nn] <= d + 1) continue;
                q.push(make_pair(-(d+1), nn+MAX));
            }
        }

        return dist[N];
    }
};

// CUT begin
ifstream data("Deadfish.sample");

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

bool do_test(int N, int __expected) {
    time_t startClock = clock();
    Deadfish *instance = new Deadfish();
    int __result = instance->shortestCode(N);
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
        int N;
        from_stream(N);
        next_line();
        int __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(N, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1524328000;
        double PT = T / 60.0, TT = 75.0;
        cout << "Time   : " << T / 60 << " minutes " << T % 60 << " secs" << endl;
        cout << "Score  : " << 1000 * (0.3 + (0.7 * TT * TT) / (10.0 * PT * PT + TT * TT)) << " points" << endl;
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
        cout << "Deadfish (1000 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

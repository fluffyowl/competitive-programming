#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;

const ll MOD = 1000000007;
ll dp[1010][2];
bool can_change[1010];

bool is_digit(char c) {
    return '0' <= c && c <= '9';
}

class WordAndPhraseDiv1 {
    public:
    int findNumberOfPhrases(string w) {
        memset(dp, 0, sizeof(dp));
        memset(can_change, 0, sizeof(can_change));
        int N = w.size();

        for (int i = 1; i < N-1; ++i)
            if (w[i] == '_' && !is_digit(w[i+1]))
                can_change[i] = true;

        dp[0][0] = 1;

        for (int i = 0; i < N; ++i) {
            if (can_change[i]) {
                dp[i+1][0] = (dp[i][0] + dp[i][1]) % MOD;
                dp[i+1][1] = dp[i][0] % MOD;
            } else {
                dp[i+1][0] = (dp[i][0] + dp[i][1]) % MOD;
            }
        }

        //REP(i, N) cout << dp[i][0] << " " << dp[i][1] << " " << can_change[i] << endl;
        return (dp[N][0] + dp[N][1]) % MOD;
    }
};

// CUT begin
ifstream data("WordAndPhraseDiv1.sample");

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

bool do_test(string w, int __expected) {
    time_t startClock = clock();
    WordAndPhraseDiv1 *instance = new WordAndPhraseDiv1();
    int __result = instance->findNumberOfPhrases(w);
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
        string w;
        from_stream(w);
        next_line();
        int __answer;
        from_stream(__answer);

        cases++;
        if (case_set.size() > 0 && case_set.find(cases - 1) == case_set.end())
            continue;

        cout << "  Testcase #" << cases - 1 << " ... ";
        if ( do_test(w, __answer)) {
            passed++;
        }
    }
    if (mainProcess) {
        cout << endl << "Passed : " << passed << "/" << cases << " cases" << endl;
        int T = time(NULL) - 1527318211;
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
        cout << "WordAndPhraseDiv1 (500 Points)" << endl << endl;
    }
    return run_test(mainProcess, cases, argv[0]);
}
// CUT end

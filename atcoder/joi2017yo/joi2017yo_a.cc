#include <bits/stdc++.h>

using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)


int main() {
    int a, b, c, d, e;
    cin >> a >> b >> c >> d >> e;


    bool frozen = a < 0;
    int ans = 0;

    while (a < b) {
        if (frozen && a < 0) {
            ans += c;
            a += 1;
        }
        else if (frozen && a == 0) {
            ans += d;
            frozen = false;
        }
        else {
            ans += e;
            a += 1;
        }
    }

    cout << ans << endl;
}

#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)

ll calc(ll d) {
    return (ll)((-1 + sqrt(1 + 4*d)) / 2.0);
}


int main() {
    int cnt = 0;
    for (ll i = 900000000; ; ++i) {
        //ll d = i * i + i;
        //ll t = calc(d);
        printf("%lld\n", i * i + i - 1);
        cnt++;
        if (cnt == 100000) break;
    }
    
    return 0;
}


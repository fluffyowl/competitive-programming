tr '\n' ' ' | gawk '{
    n = $1
    for (i = 1; i <= n; i++) {
        a[i] = 0
        b[i] = 0
        ans[i] = 0
    }
    for (i = 1; i <= n; i++) {
        a[$(i+1)] = i;
        b[$(i+1+n)] = i; 
    }

    last = 1000000
    for (i = n+1; i > 1; i--) {
        if (b[$i] < last) {
            ans[$i] = 1
            last = b[$i]
        }
    }

    for (i = 1; i <= n; i++) {
        if (ans[i]) {
            print(i)
        }
    }
}'

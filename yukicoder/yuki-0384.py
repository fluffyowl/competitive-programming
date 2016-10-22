H, W, N, K = map(int, raw_input().split())
print 'YES' if (H+W-1)%N == K or ((H+W-1)%N==0 and N==K) else 'NO'


import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto S = readln.chomp;
    auto N = S.length.to!int;

    int[] cnt = new int[](26);
    foreach (s; S) cnt[s-'a'] += 1;

    if (cnt.map!(c => c % 2).sum > 1) {
        writeln(-1);
        return;
    }

    int[] cnt2 = new int[](26);
    string s1, s2;

    foreach(s; S) {
        int c = s - 'a';
        cnt2[c] += 1;
        if (cnt2[c] <= (cnt[c] + 1) / 2) s1 ~= s;
        else s2 ~= s;
    }

    auto number = new int[][](26);
    int tmp = 0;
    foreach (s; s1) number[s-'a'] ~= tmp++;

    int[] cnt3 = new int[](26);
    int[] new_s = new int[](N);
    foreach (i; 0..N) {
        int c = S[N-i-1] - 'a';
        if (cnt3[c] + 1 == number[c].length && cnt[c] % 2) new_s[i] = 2*N - 2, cnt3[c]++;
        else if (cnt3[c] < number[c].length) new_s[i] = number[c][cnt3[c]++];
        else new_s[i] = 2*N-1;
    }
    
    auto st = new SegmentTree(2*N+1);
    long ans;
    foreach (s; new_s) {
        ans += st.sum(s+1, 2*N+1);
        st.add(s, 1);
    }
    ans.writeln;
}

class SegmentTree {
    long[] table;
    int size;

    this(int n) {
        assert(bsr(n) < 29);
        size = 1 << (bsr(n) + 2);
        table = new long[](size);
    }

    void add(int pos, long num) {
        return add(pos, num, 0, 0, size/2-1);
    }

    void add(int pos, long num, int i, int left, int right) {
        table[i] += num;
        if (left == right)
            return;
        auto mid = (left + right) / 2;
        if (pos <= mid)
            add(pos, num, i*2+1, left, mid);
        else
            add(pos, num, i*2+2, mid+1, right);
    }

    long sum(int pl, int pr) {
        return sum(pl, pr, 0, 0, size/2-1);
    }

    long sum(int pl, int pr, int i, int left, int right) {
        if (pl > right || pr < left)
            return 0;
        else if (pl <= left && right <= pr)
            return table[i];
        else
            return
                sum(pl, pr, i*2+1, left, (left+right)/2) +
                sum(pl, pr, i*2+2, (left+right)/2+1, right);
    }
}

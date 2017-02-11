import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


class SegmentTree {
    immutable long INF = 1L << 60;
    long[] table;
    int N, table_size;

    this(int n) {
        N = n;
        table_size = 1;
        while (table_size < n) table_size *= 2;
        table_size *= 2;
        table = new long[](table_size);
        fill(table, INF);
    }

    void update(int pos, long num) {
        update_rec(0, 0, table_size/2-1, pos, num);
    }
    
    long update_rec(int i, int left, int right, int pos, long num) {
        if (left == right) {
            table[i] = min(num, table[i]);
            return table[i];
        }
        auto mid = (left + right) / 2;
        if (pos <= mid) {
            table[i] = min(update_rec(i*2+1, left, mid, pos, num),
                           table[i*2+2]);
        }
        else {
            table[i] = min(table[i*2+1], 
                           update_rec(i*2+2, mid+1, right, pos, num));
        }
        return table[i];
    }

    long getmin(int pl, int pr) {
        return getmin_rec(0, pl, pr, 0, table_size/2-1);
    }
    
    long getmin_rec(int i, int pl, int pr, int left, int right) {
        if (pl > right || pr < left)
            return INF;
        else if (pl <= left && right <= pr)
            return table[i];
        else
            return min(getmin_rec(i*2+1, pl, pr, left, (left+right)/2), 
                       getmin_rec(i*2+2, pl, pr, (left+right)/2+1, right));
    }
}

void main() {
    alias Tuple!(int, "l", int, "r", long, "cost") Light;
    
    int N, L, l, r, c;
    scanf("%d %d", &N, &L);
    
    auto lights = new Light[](N);
    foreach (i; 0..N) {
        scanf("%d %d %lld", &l, &r, &c);
        lights[i] = Light(l, r, c);
    }
    
    lights.sort!"a.l < b.l"();

    
    auto sg = new SegmentTree(L+1);
    sg.update(0, 0);
    
    foreach (light; lights) {
        auto m = sg.getmin(light.l, light.r);
        sg.update(light.r, m+light.cost);
    }

    sg.getmin(L, L).writeln;
}

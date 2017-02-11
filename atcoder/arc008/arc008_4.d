import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;

class SegmentTree {
    real[] table_a, table_b;
    int N, table_size;

    this(int n) {
        N = n;
        table_size = 1;
        while (table_size < n) table_size *= 2;
        table_size *= 2;
        table_a = new real[](table_size);
        table_b = new real[](table_size);
        fill(table_a, 1);
        fill(table_b, 0);
    }

    void update(int pos, real a, real b) {
        update_rec(0, 0, table_size/2-1, pos, a, b);
    }

    void update_rec(int i, int left, int right, int pos, real a, real b) {
        if (left == right) {
            table_a[i] = a;
            table_b[i] = b;
            return;
        }
        
        auto mid = (left + right) / 2;
        
        if (pos <= mid) update_rec(i*2+1, left, mid, pos, a, b);
        else            update_rec(i*2+2, mid+1, right, pos, a, b);
        
        auto a1 = table_a[i*2+1];
        auto b1 = table_b[i*2+1];
        auto a2 = table_a[i*2+2];
        auto b2 = table_b[i*2+2];
        table_a[i] = a1 * a2;
        table_b[i] = a2 * b1 + b2;
        return;
    }

    real calc(real r) {
        return table_a[0] * r + table_b[0];
    } 
}

void main() {
    auto s = readln.split;
    auto M = s[1].to!int;

    if (M == 0) {
        writefln("%.10f\n%.10f", 1.0L, 1.0L);
        return;
    }
    
    alias Tuple!(long, "p", int, "q", real, "a", real, "b") Query;
    auto queries = new Query[](M);
    
    foreach (i; 0..M) {
        auto t = readln.split;
        auto p = t[0].to!long;
        auto a = t[1].to!real;
        auto b = t[2].to!real;
        queries[i] = Query(p, i, a, b);
    }

    queries.sort!"a.p < b.p"();
    
    long prev_p = queries[0].p;
    long j = 0;
    foreach(i; 0..M) {
        if (prev_p != queries[i].p) j++;
        prev_p = queries[i].p;
        queries[i].p = j;
    }

    
    queries.sort!"a.q < b.q"();
    
    auto sg = new SegmentTree(M);
    real mx = 1;
    real mn = 1;

    foreach(i; 0..M) {
        sg.update(queries[i].p.to!int, queries[i].a, queries[i].b);
        auto r = sg.calc(1);
        mx = max(mx, r);
        mn = min(mn, r);
    }
    

    writefln("%.10f\n%.10f", mn, mx);

}

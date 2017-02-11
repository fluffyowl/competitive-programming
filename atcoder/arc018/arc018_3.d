import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;


void main() {
    int N, M, x, a, p;
    scanf("%d %d", &N, &M);
    scanf("%d %d %d", &x, &a, &p);

    if (a % p == 0) {
        writeln((x > (x + a) % p) ? 2*(N-1) : 0);
        return;
    }

    alias Tuple!(int, "grade", int, "r", int, "c", int, "to") Seat;
    auto A = new Seat[](N*M);
    A[0] = Seat(x, 0, 0, 0);
    foreach (i; 1..N*M) {
        A[i] = Seat((A[i-1].grade + a) % p, i / M, i % M, 0);
    }
    
    A.sort!"a.grade < b.grade"();

    int ans = 0;
    auto emp = new int[][](N);
    auto to_row = new int[][](N);
    foreach (i; 0..N*M) {
        int row = i / M;
        if (row != A[i].r) {
            ans += abs(A[i].r-row);
            emp[A[i].r] ~= A[i].c;
            to_row[row] ~= A[i].c;
        }
    }

    foreach (i; 0..N) {
        emp[i].sort();
        to_row[i].sort();
        for (int j = 0; j < emp[i].length; j++)
            ans += abs(emp[i][j] - to_row[i][j]);
    }

    ans.writeln;

}

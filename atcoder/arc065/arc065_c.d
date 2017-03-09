import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;
     
alias Tuple!(int, "x", int, "y") Point;
     
void main() {
    auto s = readln.split.map!(to!int);
    auto N = s[0];
    auto A = s[1]-1;
    auto B = s[2]-1;
    auto X = new int[](N);
    auto Y = new int[](N);
    int[][int] X_Y;
    int[][int] Y_X;
    foreach (i; 0..N) {
        s = readln.split.map!(to!int);
        X[i] = s[0] + s[1];
        Y[i] = s[0] - s[1];
        X_Y[X[i]] ~= Y[i];
        Y_X[Y[i]] ~= X[i];
    }

    RedBlackTree!(int)[int] rbtX_Y;
    RedBlackTree!(int)[int] rbtY_X;
    foreach (k; X_Y.keys) {
        X_Y[k].sort();
        rbtX_Y[k] = new RedBlackTree!(int)();
        rbtX_Y[k].insert(X_Y[k].dup);
    }
    foreach (k; Y_X.keys) {
        Y_X[k].sort();
        rbtY_X[k] = new RedBlackTree!(int)();
        rbtY_X[k].insert(Y_X[k].dup);
    }
     
    int manh = max(abs(X[A]-X[B]), abs(Y[A]-Y[B]));
    bool[int][int] used;
    DList!Point q;
    q.insert(Point(X[A], Y[A]));
    long ans = 0;
        
    while (!q.empty) {
        auto n = q.front;
        auto x = n.x;
        auto y = n.y;
        q.removeFront;
        if (x in used && y in used[x])
            continue;
        used[x][y] = true;
     
        foreach (d; [manh, -manh]) {
            auto nx = x + d;
            if (!(nx in X_Y)) continue;
            long lb = assumeSorted(X_Y[nx]).lowerBound(y-manh).length.to!long;
            long ub = assumeSorted(X_Y[nx]).lowerBound(y+manh+1).length.to!long;
            ans += (ub - lb);

            int[] ys;
            foreach (i; rbtX_Y[nx].upperBound(y-manh-1)) {
                if (i > y + manh) break;
                ys ~= i;
            }
            foreach (ny; ys) {
                if (ny > y + manh) break;
                q.insert(Point(nx, ny));
                rbtX_Y[nx].removeKey(ny);
            }
        }
     
        foreach (d; [manh, -manh]) {
            auto ny = y + d;
            if (!(ny in Y_X)) continue;
            long lb = assumeSorted(Y_X[ny]).lowerBound(x-manh+1).length.to!long;
            long ub = assumeSorted(Y_X[ny]).lowerBound(x+manh).length.to!long;
            ans += (ub - lb);
     
            int[] xs;
            foreach (i; rbtY_X[ny].upperBound(x-manh)) {
                if (i >= x + manh) break;
                xs ~= i;
            }
            foreach (nx; xs) {
                if (nx >= x + manh) break;
                q.insert(Point(nx, ny));
                rbtY_X[ny].removeKey(nx);
            }

        }        
    }
     
    writeln(ans/2);
}

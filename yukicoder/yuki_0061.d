import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio;

void main() {
    int Q;
    scanf("%d", &Q);
    
    foreach (i; 0..Q) {
        int W, H, D, mx, my, hx, hy, vx, vy;
        scanf("%d %d %d %d %d %d %d %d %d", &W, &H, &D, &mx, &my, &hx, &hy, &vx, &vy);

        auto g = gcd(abs(vx), abs(vy));
        auto used = new bool[][][][](W+1, H+1, 2, 2);
        bool hit = false;
        bool end = false;
        
        foreach (_; 0..D) {
            foreach (j; 0..g) {
                
                hx += vx/g, hy += vy/g;
                
                while (hx < 0 || hx > W) {
                    if (hx > W) {
                        hx = 2 * W - hx;
                        vx *= -1;
                    }
                    else if (hx < 0) {
                        hx = -hx;
                        vx *= -1;
                    }
                }
                while (hy < 0 || hy > H) {
                    if (hy > H) {
                        hy = 2 * H - hy;
                        vy *= -1;
                    }
                    else if (hy < 0) {
                        hy = -hy;
                        vy *= -1;
                    }
                }

                if (hx == mx && hy == my) {
                    hit = true;
                    end = true;
                    break;
                }
                if (used[hx][hy][vx>0][vy>0]) {
                    end = true;
                    break;
                }

                used[hx][hy][vx>0][vy>0] = true;
            }
            
            if (end) break;
        }

        writeln(hit ? "Hit" : "Miss");
    }
}


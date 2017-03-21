import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.stdio, std.bitmanip;

alias Tuple!(int, "a", int, "b", int, "c", int, "d", int, "i") Car;

immutable int H = 30;
immutable int W = 30;
immutable int K = 450;
immutable int T = 1000;

real final_score = 0;
char[K][T] final_command;
int final_mt;
Car[K] cars_first;

void search() {
    char[K][T] commands;
    int[T] scores;
    Car[K] cars;
    bool[H][W] used;
    int L = 0;
    int[] a = [0, 1, 2, 3, 4];
    int[] b = K.iota.array;
    char[] dirs = ['D', 'U', 'R', 'L', '-'];

    void command(int t, int i, char d) {
        commands[t][i] = d;
        if (d == 'D') cars[i].a += 1;
        else if (d == 'U') cars[i].a -= 1;
        else if (d == 'R') cars[i].b += 1;
        else if (d == 'L') cars[i].b -= 1;
        used[cars[i].a][cars[i].b] = true;
    }

    cars = cars_first.dup;
    foreach (t; 0..T) {
        foreach (i; 0..H) foreach (j; 0..W) used[i][j] = false;
        foreach (i; 0..K) used[cars[i].a][cars[i].b] = true;
        randomShuffle(b);
        foreach (i; b) {
            auto car = cars[i];
            scores[t] += abs(car.a - car.c) + abs(car.b - car.d);
            if (car.a - car.c < 0 && !used[car.a+1][car.b]) {
                command(t, car.i, 'D');
            }
            else if (car.a - car.c > 0 && !used[car.a-1][car.b]) {
                command(t, car.i, 'U');
            }
            else if (car.b - car.d < 0 && !used[car.a][car.b+1]) {
                command(t, car.i, 'R');
                }
            else if (car.b - car.d > 0 && !used[car.a][car.b-1]) {
                command(t, car.i, 'L');
            }

            else {
                foreach (d; randomCover(a)) {
                    if (d == 0 && car.a < H-1 && !used[car.a+1][car.b]) {
                        command(t, car.i, dirs[d]);
                        break;
                    }
                    if (d == 1 && car.a > 0 && !used[car.a-1][car.b]) {
                        command(t, car.i, dirs[d]);
                        break;
                    }
                    if (d == 2 && car.b < W-1 && !used[car.a][car.b+1]) {
                        command(t, car.i, dirs[d]);
                        break;
                    }
                    if (d == 3 && car.b > 0 && !used[car.a][car.b-1]) {
                        command(t, car.i, dirs[d]);
                        break;
                    }
                    if (d == 4) {
                        command(t, car.i, dirs[d]);
                        break;
                    }
                }
            }
        }
    }

    int mt = -1;
    real ms = -1;
    foreach (t; 0..T) {
        int pd = scores[t] + 20;
        real pt = 10 + t * 0.01L;
        real score = 10L^^7/(pd*pt);
        if(score > ms) {
            ms = score;
            mt = t;
        }
    }

    if (ms > final_score) {
        final_score = ms;
        foreach (t; 0..T) foreach (i; 0..K)
            final_command[t][i] = commands[t][i];
        final_mt = mt;
    }

}

void main() {
    readln;
    foreach (i; 0..K) {
        auto s = readln.split.map!(to!int);
        cars_first[i] = Car(s[0]-1, s[1]-1, s[2]-1, s[3]-1, i);
    }


    foreach (tt; 0..22) {
        search;
    }

    final_mt.writeln;
    foreach (i; 0..final_mt) final_command[i].writeln;
}

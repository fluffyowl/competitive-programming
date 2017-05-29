import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop;



void main() {
    auto N = readln.chomp.to!int;

    string d1 = "..##";
    string d2 = ".#.#";
    string r1 = "";
    string r2 = "";
    bool right_end = false;
    
    while (true) {
        bool t = false;
        foreach (k; 0..4) {
            if (right_end) {
                r1 = d1[k] ~ r1;
                r2 = d2[k] ~ r2;
            }
            else {
                r1 = r1 ~ d1[k];
                r2 = r2 ~ d2[k];
            }
            writeln(r1);
            writeln(r2);
            stdout.flush;
            string tf = readln.chomp;
            if (tf == "T") {
                t = true;
                break;
            }
            else if (tf == "end")
                return;
            
            if (right_end) {
                r1 = r1[1..$];
                r2 = r2[1..$];
            }
            else {
                r1 = r1[0..$-1];
                r2 = r2[0..$-1];
            }
        }

        if (!t) {
            right_end = true;
            N += 1;
        }
        
    }
}

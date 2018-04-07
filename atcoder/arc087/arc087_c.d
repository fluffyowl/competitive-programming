import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto t = readln.split;
    auto N = t[0].to!int;
    auto L = t[1].to!long;
    auto S = N.iota.map!(_ => readln.chomp).array;

    auto tr = new Trie(L);
    foreach (s; S) {
        tr.add_string(s);
    }

    writeln(tr.search ? "Alice" : "Bob");
}


class Node {
    int d;
    Node[2] children;

    this(int d) {
        this.d = d;
    }
}

class Trie {
    Node root;
    long L;

    this(long L) {
        root = new Node(0);
        this.L = L;
    }

    void add_string(string s) {
        Node cur = root;
        foreach (c; s) {
            if (cur.children[c-'0'] is null) {
                cur.children[c-'0'] = new Node(cur.d+1);
            }
            cur = cur.children[c-'0'];
        }
    }

    long search() {
        return search(root);
    }
    
    long search(Node n) {
        long l = L - n.d;
        long i = 1;
        while (l != 0 && l % (i * 2) == 0) i *= 2;
        
        if (n.children[0] is null && n.children[1] is null) {
            return 0;
        } else if (n.children[0] is null) {
            return search(n.children[1]) ^ i;
        } else if (n.children[1] is null) {
            return search(n.children[0]) ^ i;            
        } else {
            return search(n.children[0]) ^ search(n.children[1]);            
        }
    }
}

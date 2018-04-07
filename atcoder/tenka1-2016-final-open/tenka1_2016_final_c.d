import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

void main() {
    auto S = readln.chomp;
    auto M = readln.chomp.to!int;
    auto P = M.iota.map!(_ => readln.chomp).array;
    auto W = M.iota.map!(_ => readln.chomp.to!int).array;
    auto N = S.length.to!int;

    auto trie = new Trie;
    foreach (i; 0..M) {
        trie.add_word(P[i], W[i]);
    }

    auto dp = new int[](N+1);
    foreach (i; 0..N) {
        dp[i+1] = max(dp[i+1], dp[i]);
        auto x = trie.search(S[i..min(i+200, N)]);
        foreach (j; 1..x.length) {
            dp[i+j] = max(dp[i+j], dp[i] + x[j]);
        }
    }

    dp[N].writeln;
}


class Node {
    int w;
    Node[char] children;

    this (int w) {
        this.w = w;
    }
}


class Trie {
    Node root;
    
    this() {
        root = new Node(0);
    }

    void add_word(string s, int w) {
        auto cur = root;
        foreach (c; s) {
            if (c !in cur.children) {
                cur.children[c] = new Node(0);
            }
            cur = cur.children[c];
        }
        cur.w = w;
    }

    int[] search(string s) {
        int[] ret = [0];
        auto cur = root;
        foreach (c; s) {
            if (c !in cur.children) {
                break;
            }
            cur = cur.children[c];
            ret ~= cur.w;
        }
        return ret;
    }
}

import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.bitmanip;

immutable long MOD = 10^^9 + 7;

class Node {
    char op;
    int num;
    long val;
    long a = 1;
    long b = 0;
    Node left;
    Node right;
}

void ins(ref DList!Node seq, Node n) {
    if (!seq.empty && seq.back.op == '*') {
        seq.removeBack;
        auto m = new Node();
        m.op = '*';
        m.left = seq.back;
        m.right = n;
        seq.removeBack;
        seq.insertBack(m);
    } else {
        seq.insertBack(n);
    }
}


void main() {
    auto S = readln.chomp;
    auto Q = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    auto a = new long[](10^^5);
    auto b = new long[](10^^5);

    int p = 0;
    int cnt = 0;


    Node parse() {
        DList!Node ret;

        while (p < S.length) {
            if (S[p] == 'a') {
                auto n = new Node();
                n.op = 0;
                n.num = cnt++;
                ins(ret, n);
                ++p;
            } else if (S[p] == '(') {
                ++p;
                ins(ret, parse());
            } else if (S[p] == ')') {
                ++p;
                break;
            } else if (S[p] == '*') {
                auto n = new Node();
                n.op = '*';
                ret ~= n;
                ++p;
            } else {
                auto n = new Node();
                n.op = S[p];
                ret ~= n;
                ++p;
            }
        }

        auto ans = new Node();
        ans.op = ret.front.op;
        ans.num = ret.front.num;
        ans.left = ret.front.left;
        ans.right = ret.front.right;
        ret.removeFront;

        while (!ret.empty) {
            auto nans = new Node();
            nans.op = ret.front.op;
            ret.removeFront;
            nans.left = ans;
            nans.right = ret.front;
            ret.removeFront;
            ans = nans;
        }

        return ans;
    }


    void dfs(Node n) {
        if (n.op != 0) {
            dfs(n.left);
            dfs(n.right);
        }
        if (n.op == 0) {
            n.val = A[n.num];
        } else if (n.op == '+') {
            n.val = (n.left.val + n.right.val) % MOD;
        } else if (n.op == '-') {
            n.val = (n.left.val - n.right.val) % MOD;
        } else {
            n.val = n.left.val * n.right.val % MOD;
        }
    }


    void solve(Node n) {
        if (n.op == 0) {
            a[n.num] = n.a;
            b[n.num] = n.b;
            return;
        }

        if (n.op == '+') {
            n.left.a = n.a;
            n.left.b = (n.b + n.a * n.right.val % MOD) % MOD;
            n.right.a = n.a;
            n.right.b = (n.b + n.a * n.left.val % MOD) % MOD;
        } else if (n.op == '-') {
            n.left.a = n.a;
            n.left.b = (n.b - n.a * n.right.val % MOD) % MOD;
            n.right.a = -n.a;
            n.right.b = (n.a * n.left.val % MOD + n.b) % MOD;
        } else {
            n.left.a = n.a * n.right.val % MOD;
            n.left.b = n.b;
            n.right.a = n.a * n.left.val % MOD;
            n.right.b = n.b;
        }

        solve(n.left);
        solve(n.right);
    }


    auto root = parse();
    dfs(root);
    solve(root);

    while (Q--) {
        auto s = readln.split.map!(to!int);
        int B = s[0] - 1;
        long X = s[1];
        long ans = a[B] * X % MOD + b[B];
        ans = (ans % MOD + MOD) % MOD;
        ans.writeln;
    }

}

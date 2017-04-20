import std.stdio, std.array, std.string, std.conv, std.algorithm;
import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, core.stdc.string;


alias Tuple!(long, "day", long, "money") Node;

void main() {
    auto N = readln.chomp.to!int;
    auto A = readln.split.map!(to!long).array;
    auto B = readln.split.map!(to!long).array;

    //auto costs = new long[](N+1);
    //costs[0] = 0;
    //foreach (i; 0..N) costs[i+1] = costs[i] + A[i];

    long max_income = 0;
    auto dp = new Node[](N+1);
    fill(dp, Node(-1, -1));
    dp[0] = Node(0, 0);

    foreach (i; 0..N) {
        max_income = max(max_income, B[i]);
        auto c = A[i];
        if (dp[i].money + c >= 0) {
            if (dp[i].day + 1 > N) break;
            dp[i+1] = Node(dp[i].day + 1, dp[i].money + c);
        }
        else if (max_income <= 0){
            break;
        }
        else {
            long shortage = - (dp[i].money + c);
            long yokei_day = (shortage - 1) / max_income + 1;
            if (dp[i].day + yokei_day + 1 > N) break;
            dp[i+1] = Node(dp[i].day + yokei_day + 1, dp[i].money + c + max_income * yokei_day);
        }

    }


    long ans = B[0] * N;
    max_income = B[0];

    foreach (i; 1..N+1) {
        if (dp[i].day == -1) break;
        if (i < N)
            max_income = max(max_income, B[i]);
        long yokei_day = N - dp[i].day;
        if (yokei_day < 0) continue;
        ans = max(ans, dp[i].money + yokei_day * max_income);
    }

    ans.writeln;
}

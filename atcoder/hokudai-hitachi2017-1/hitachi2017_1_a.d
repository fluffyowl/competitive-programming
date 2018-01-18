import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.datetime;
import std.stdio, std.array, std.string, std.conv, std.algorithm;

immutable int INF = 1 << 29;

SysTime start_time;

int V, E, Vemb, Eemb;
int[][] edges_mat;
Tuple!(int, int)[][] edges_lst;
bool[][] emb_edges_mat;
int[][] emb_edges_lst;
int[] best_ans;
int best_score;

immutable int CANDIDATES_COUNT = 1;
immutable int BEAM_WIDTH = 1;


struct LightNode {
    int score;
    int u;
    int u_emb;
    BeamNode parent;
}


class BeamNode {
    int[] perm;
    int[] perm_rev;
    bool[int] frontier;
    bool[int] closed;
    int score;
    int turn;

    this(int[] perm, int[] perm_rev, bool[int] frontier, bool[int] closed, int score, int turn) {
        this.perm = perm;
        this.perm_rev = perm_rev;
        this.frontier = frontier;
        this.closed = closed;
        this.score = score;
        this.turn = turn;
    }

    static BeamNode generate_random_init_state() {
        int u = uniform(0, V);
        int u_emb = uniform(0, Vemb);

        auto new_perm = new int[](V);
        auto new_perm_rev = new int[](Vemb);
        bool[int] new_frontier;
        bool[int] new_closed;

        new_perm.fill(Vemb);
        new_perm_rev.fill(Vemb);

        new_perm[u] = u_emb;
        new_perm_rev[u_emb] = u;
        new_closed[u_emb] = true;
        foreach (v_emb; emb_edges_lst[u_emb]) {
            new_frontier[v_emb] = true;
            new_closed[v_emb] = true;
        }

        return new BeamNode(new_perm, new_perm_rev, new_frontier, new_closed, 0, 1);
    }

    BeamNode[] generate_next_states() {
        BeamNode[] ret;

        foreach (u; 0..V) {
            if (perm[u] < Vemb) continue;

            foreach (f; frontier.keys) {
                int diff = 0;
                foreach (g; emb_edges_lst[f]) {
                    if (perm_rev[g] < V) {
                        diff += edges_mat[u][perm_rev[g]];
                    }
                }

                auto new_perm = perm.dup;
                new_perm[u] = f;

                auto new_perm_rev = perm_rev.dup;
                new_perm_rev[f] = u;

                auto new_frontier = frontier.dup;
                auto new_closed = closed.dup;
                foreach (v_emb; emb_edges_lst[f]) {
                    if (!(v_emb in new_closed)) {
                        new_frontier[v_emb] = true;
                        new_closed[v_emb] = true;
                    }
                }
                new_frontier.remove(f);

                ret ~= new BeamNode(new_perm, new_perm_rev, new_frontier, new_closed, score+diff, turn+1);
            }
        }

        return ret;
    }


    LightNode[] generate_next_states_light() {
        LightNode[] ret;

        foreach (u; 0..V) {
            if (perm[u] < Vemb) continue;

            foreach (f; frontier.keys) {
                int diff = 0;
                foreach (g; emb_edges_lst[f]) {
                    if (perm_rev[g] < V) {
                        diff += edges_mat[u][perm_rev[g]];
                    }
                }
                ret ~= LightNode(score+diff, u, f, this);
            }
        }

        return ret;
    }


    BeamNode apply(int u, int u_emb, int new_score) {
        auto new_perm = perm.dup;
        auto new_perm_rev = perm_rev.dup;
        auto new_frontier = frontier.dup;
        auto new_closed = closed.dup;
        auto new_turn = turn + 1;

        new_perm[u] = u_emb;
        new_perm_rev[u_emb] = u;
        new_closed[u_emb] = true;

        foreach (v_emb; emb_edges_lst[u_emb]) {
            if (!(v_emb in new_closed)) {
                new_frontier[v_emb] = true;
                new_closed[v_emb] = true;
            }
        }

        new_frontier.remove(u_emb);

        return new BeamNode(new_perm, new_perm_rev, new_frontier, new_closed, new_score, new_turn);
    }
}


void beam_search() {
    BeamNode[] current_nodes;
    LightNode[] next_nodes;

    foreach (i; 0..CANDIDATES_COUNT) {
        current_nodes ~= BeamNode.generate_random_init_state;
    }


    foreach (turn; 1..V) {
        foreach (node; current_nodes) {
            foreach (next_node; node.generate_next_states_light) {
                next_nodes ~= next_node;
            }
        }

        next_nodes.sort!"a.score > b.score";
        current_nodes = [];
        int cnt = 0;
        foreach (node; next_nodes) {
            if (cnt >= BEAM_WIDTH) break;
            current_nodes ~= node.parent.apply(node.u, node.u_emb, node.score);
            cnt += 1;
        }
        next_nodes = [];
    }

    if (current_nodes[0].score > best_score) {
        best_score = current_nodes[0].score;
        foreach (i; 0..V) {
            best_ans[i] = current_nodes[0].perm[i];
        }
    }
}

void main() {
    start_time = Clock.currTime();
    input();
    best_ans = new int[](V);
    while ((Clock.currTime - start_time).total!"msecs" < dur!"msecs"(9000).total!"msecs")
        beam_search;
    foreach (i; 0..V) {
        writeln(i+1, " ", best_ans[i]+1);
    }
}


void input() {
    auto s = readln.split.map!(to!int);
    V = s[0];
    E = s[1];
    edges_mat = new int[][](V, V);
    edges_lst = new Tuple!(int, int)[][](V);
    foreach (_; 0..E) {
        s = readln.split.map!(to!int);
        edges_mat[s[0]-1][s[1]-1] = s[2];
        edges_mat[s[1]-1][s[0]-1] = s[2];
        edges_lst[s[0]-1] ~= tuple(s[1]-1, s[2]);
        edges_lst[s[1]-1] ~= tuple(s[0]-1, s[2]);
    }

    s = readln.split.map!(to!int);
    Vemb = s[0];
    Eemb = s[1];
    emb_edges_mat = new bool[][](Vemb, Vemb);
    emb_edges_lst = new int[][](Vemb);
    foreach (_; 0..Eemb) {
        s = readln.split.map!(to!int);
        emb_edges_mat[s[0]-1][s[1]-1] = true;
        emb_edges_mat[s[1]-1][s[0]-1] = true;
        emb_edges_lst[s[0]-1] ~= s[1]-1;
        emb_edges_lst[s[1]-1] ~= s[0]-1;
    }
} import std.typecons, std.range, std.random, std.math, std.container;
import std.numeric, std.bigint, core.bitop, std.datetime;
import std.stdio, std.array, std.string, std.conv, std.algorithm;

immutable int INF = 1 << 29;

SysTime start_time;

int V, E, Vemb, Eemb;
int[][] edges_mat;
Tuple!(int, int)[][] edges_lst;
bool[][] emb_edges_mat;
int[][] emb_edges_lst;
int[] best_ans;
int best_score;

immutable int CANDIDATES_COUNT = 1;
immutable int BEAM_WIDTH = 1;


struct LightNode {
    int score;
    int u;
    int u_emb;
    BeamNode parent;
}


class BeamNode {
    int[] perm;
    int[] perm_rev;
    bool[int] frontier;
    bool[int] closed;
    int score;
    int turn;

    this(int[] perm, int[] perm_rev, bool[int] frontier, bool[int] closed, int score, int turn) {
        this.perm = perm;
        this.perm_rev = perm_rev;
        this.frontier = frontier;
        this.closed = closed;
        this.score = score;
        this.turn = turn;
    }

    static BeamNode generate_random_init_state() {
        int u = uniform(0, V);
        int u_emb = uniform(0, Vemb);

        auto new_perm = new int[](V);
        auto new_perm_rev = new int[](Vemb);
        bool[int] new_frontier;
        bool[int] new_closed;

        new_perm.fill(Vemb);
        new_perm_rev.fill(Vemb);

        new_perm[u] = u_emb;
        new_perm_rev[u_emb] = u;
        new_closed[u_emb] = true;
        foreach (v_emb; emb_edges_lst[u_emb]) {
            new_frontier[v_emb] = true;
            new_closed[v_emb] = true;
        }

        return new BeamNode(new_perm, new_perm_rev, new_frontier, new_closed, 0, 1);
    }

    BeamNode[] generate_next_states() {
        BeamNode[] ret;

        foreach (u; 0..V) {
            if (perm[u] < Vemb) continue;

            foreach (f; frontier.keys) {
                int diff = 0;
                foreach (g; emb_edges_lst[f]) {
                    if (perm_rev[g] < V) {
                        diff += edges_mat[u][perm_rev[g]];
                    }
                }

                auto new_perm = perm.dup;
                new_perm[u] = f;

                auto new_perm_rev = perm_rev.dup;
                new_perm_rev[f] = u;

                auto new_frontier = frontier.dup;
                auto new_closed = closed.dup;
                foreach (v_emb; emb_edges_lst[f]) {
                    if (!(v_emb in new_closed)) {
                        new_frontier[v_emb] = true;
                        new_closed[v_emb] = true;
                    }
                }
                new_frontier.remove(f);

                ret ~= new BeamNode(new_perm, new_perm_rev, new_frontier, new_closed, score+diff, turn+1);
            }
        }

        return ret;
    }


    LightNode[] generate_next_states_light() {
        LightNode[] ret;

        foreach (u; 0..V) {
            if (perm[u] < Vemb) continue;

            foreach (f; frontier.keys) {
                int diff = 0;
                foreach (g; emb_edges_lst[f]) {
                    if (perm_rev[g] < V) {
                        diff += edges_mat[u][perm_rev[g]];
                    }
                }
                ret ~= LightNode(score+diff, u, f, this);
            }
        }

        return ret;
    }


    BeamNode apply(int u, int u_emb, int new_score) {
        auto new_perm = perm.dup;
        auto new_perm_rev = perm_rev.dup;
        auto new_frontier = frontier.dup;
        auto new_closed = closed.dup;
        auto new_turn = turn + 1;

        new_perm[u] = u_emb;
        new_perm_rev[u_emb] = u;
        new_closed[u_emb] = true;

        foreach (v_emb; emb_edges_lst[u_emb]) {
            if (!(v_emb in new_closed)) {
                new_frontier[v_emb] = true;
                new_closed[v_emb] = true;
            }
        }

        new_frontier.remove(u_emb);

        return new BeamNode(new_perm, new_perm_rev, new_frontier, new_closed, new_score, new_turn);
    }
}


void beam_search() {
    BeamNode[] current_nodes;
    LightNode[] next_nodes;

    foreach (i; 0..CANDIDATES_COUNT) {
        current_nodes ~= BeamNode.generate_random_init_state;
    }


    foreach (turn; 1..V) {
        foreach (node; current_nodes) {
            foreach (next_node; node.generate_next_states_light) {
                next_nodes ~= next_node;
            }
        }

        next_nodes.sort!"a.score > b.score";
        current_nodes = [];
        int cnt = 0;
        foreach (node; next_nodes) {
            if (cnt >= BEAM_WIDTH) break;
            current_nodes ~= node.parent.apply(node.u, node.u_emb, node.score);
            cnt += 1;
        }
        next_nodes = [];
    }

    if (current_nodes[0].score > best_score) {
        best_score = current_nodes[0].score;
        foreach (i; 0..V) {
            best_ans[i] = current_nodes[0].perm[i];
        }
    }
}

void main() {
    start_time = Clock.currTime();
    input();
    best_ans = new int[](V);
    while ((Clock.currTime - start_time).total!"msecs" < dur!"msecs"(9000).total!"msecs")
        beam_search;
    foreach (i; 0..V) {
        writeln(i+1, " ", best_ans[i]+1);
    }
}


void input() {
    auto s = readln.split.map!(to!int);
    V = s[0];
    E = s[1];
    edges_mat = new int[][](V, V);
    edges_lst = new Tuple!(int, int)[][](V);
    foreach (_; 0..E) {
        s = readln.split.map!(to!int);
        edges_mat[s[0]-1][s[1]-1] = s[2];
        edges_mat[s[1]-1][s[0]-1] = s[2];
        edges_lst[s[0]-1] ~= tuple(s[1]-1, s[2]);
        edges_lst[s[1]-1] ~= tuple(s[0]-1, s[2]);
    }

    s = readln.split.map!(to!int);
    Vemb = s[0];
    Eemb = s[1];
    emb_edges_mat = new bool[][](Vemb, Vemb);
    emb_edges_lst = new int[][](Vemb);
    foreach (_; 0..Eemb) {
        s = readln.split.map!(to!int);
        emb_edges_mat[s[0]-1][s[1]-1] = true;
        emb_edges_mat[s[1]-1][s[0]-1] = true;
        emb_edges_lst[s[0]-1] ~= s[1]-1;
        emb_edges_lst[s[1]-1] ~= s[0]-1;
    }
}

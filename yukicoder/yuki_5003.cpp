#include <bits/stdc++.h>
using namespace std;
#define REP(i,n) for (int i=0;i<(n);i++)
#define REP2(i,m,n) for (int i=m;i<(n);i++)
typedef long long ll;
typedef long double ld;

const int N = 10000;
const int F = 5;
const int MAXB = 50;
string STATUS;
string tmp;
int BONUS = N + 10;
int FEVER = N + 10;
int SALE = N + 10;
int FEVER_A[N];
int FEVER_B[N+1];

const string action[F] = {"click", "buy", "sell", "reinforce", "enhclick"};
const string facility[F] = {"hand", "lily", "factory", "casino", "grimoire"};
const uint64_t productivity[F] = {1, 10, 120, 2000, 25000};

uint64_t buy_cost[F][MAXB];
uint64_t rein_cost[F][MAXB];
uint64_t click_cost[MAXB];

const int BEAM_WIDTH = 800;
int prev_id[BEAM_WIDTH * N + 10];
int prev_action[BEAM_WIDTH * N + 10];

const int HASH_BASE = 45;
uint64_t HASH_P[11];

struct State {
    uint16_t turn;
    uint64_t cookies;
    uint16_t click_level;
    uint16_t facility_count[F];
    uint16_t facility_level[F];
    uint64_t state_score;
    int32_t parent_id;
    int8_t parent_action;
    uint64_t hash;

    State() {
        turn = 0;
        cookies = 0;
        click_level = 0;
        memset(facility_count, 0, sizeof(facility_count));
        memset(facility_level, 0, sizeof(facility_level));
        state_score = 0;
        parent_id = -1;
        parent_action = -1;
        hash = 0;
    }

    uint64_t eval() {
        uint64_t ret = 0;
        ret += cookies;
        ret += (N - turn) * (((uint64_t)(1)) << click_level);
        ret += 6 * FEVER_B[turn] * (((uint64_t)(1)) << click_level);
        for (int i = 0; i < F; ++i) {
            ret +=
                (N - turn) *
                productivity[i] *
                (((uint64_t)(1)) << facility_level[i]) *
                facility_count[i];
            ret +=
                6 * FEVER_B[turn] *
                productivity[i] *
                (((uint64_t)(1)) << facility_level[i]) *
                facility_count[i];
        }
        return ret;
    }

    void harvest() {
        for (int i = 0; i < F; ++i) {
            cookies +=
                (FEVER_A[turn] == 1 ? 7 : 1) *
                productivity[i] *
                (((uint64_t)(1)) << facility_level[i]) *
                facility_count[i];
        }
    }

    void harvest_back() {
        for (int i = 0; i < F; ++i) {
            cookies -=
                (FEVER_A[turn] == 1 ? 7 : 1) *
                productivity[i] *
                (((uint64_t)(1)) << facility_level[i]) *
                facility_count[i];
        }
    }

    void click() {
        cookies += (FEVER_A[turn] == 1 ? 7 : 1) * (((uint64_t)(1)) << click_level);
        harvest();
        turn += 1;
    }

    void click_back() {
        turn -= 1;
        harvest_back();
        cookies -= (FEVER_A[turn] == 1 ? 7 : 1) * (((uint64_t)(1)) << click_level);
    }

    bool buy(int f) {
        uint64_t c = buy_cost[f][facility_count[f]];
        if (turn == SALE + 1) c = ceil(c * 0.9);
        if (cookies < c) return false;
        hash += HASH_P[f];
        cookies -= c;
        facility_count[f] += 1;
        harvest();
        turn += 1;
        return true;
    }

    void buy_back(int f) {
        hash -= HASH_P[f];
        turn -= 1;
        harvest_back();
        facility_count[f] -= 1;
        uint64_t c = buy_cost[f][facility_count[f]];
        if (turn == SALE + 1) c = ceil(c * 0.9);
        cookies += c;
    }

    bool sell(int f) {
        if (facility_count[f] == 0) return false;
        hash -= HASH_P[f];
        cookies += ceil(buy_cost[f][facility_count[f]-1] / 4.0);
        facility_count[f] -= 1;
        harvest();
        turn += 1;
        return true;
    }

    void sell_back(int f) {
        hash += HASH_P[f];
        turn -= 1;
        harvest_back();
        facility_count[f] += 1;
        cookies -= ceil(buy_cost[f][facility_count[f]-1] / 4.0);
    }

    bool reinforce(int f) {
        if (facility_count[f] == 0) return false;
        uint64_t c = rein_cost[f][facility_level[f]];
        if (turn == SALE + 1) c = ceil(c * 0.9);
        if (cookies < c) return false;
        hash += HASH_P[5 + f];
        cookies -= c;
        facility_level[f] += 1;
        harvest();
        turn += 1;
        return true;
    }

    void reinforce_back(int f) {
        hash -= HASH_P[5 + f];
        turn -= 1;
        harvest_back();
        facility_level[f] -= 1;
        uint64_t c = rein_cost[f][facility_level[f]];
        if (turn == SALE + 1) c = ceil(c * 0.9);
        cookies += c;
    }

    bool enhclick() {
        uint64_t c = click_cost[click_level];
        if (turn == SALE + 1) c = ceil(c * 0.9);
        if (cookies < c) return false;
        hash += HASH_P[10];
        cookies -= c;
        click_level += 1;
        harvest();
        turn += 1;
        return true;
    }

    void enhclick_back() {
        hash -= HASH_P[10];
        turn -= 1;
        harvest_back();
        click_level -= 1;
        uint64_t c = click_cost[click_level];
        if (turn == SALE + 1) c = ceil(c * 0.9);
        cookies += click_cost[click_level];
    }

    uint64_t eval_click() {
        click();
        uint64_t score = eval();
        click_back();
        return score;
    }

    uint64_t eval_buy(int f) {
        if (!buy(f)) return 0;
        uint64_t score = eval();
        buy_back(f);
        return score;
    }

    uint64_t eval_sell(int f) {
        if (!sell(f)) return 0;
        uint64_t score = eval();
        sell_back(f);
        return score;
    }

    uint64_t eval_reinforce(int f) {
        if (!reinforce(f)) return 0;
        uint64_t score = eval();
        reinforce_back(f);
        return score;
    }

    uint64_t eval_enhclick() {
        if (!enhclick()) return 0;
        uint64_t score = eval();
        enhclick_back();
        return score;
    }

    pair<int, int> best_next_action() { // for greedy search
        uint64_t best_score = 0;
        int x = -1;
        int y = 0;

        uint64_t s;

        s = eval_click();
        if (s > best_score) {
            best_score = s;
            x = 0;
        }

        REP(i, F) {
            s = eval_buy(i);
            if (s > best_score) {
                best_score = s;
                x = 1;
                y = i;
            }
        }

        REP(i, F) {
            s = eval_sell(i);
            if (s > best_score) {
                best_score = s;
                x = 2;
                y = i;
            }
        }

        REP(i, F) {
            s = eval_reinforce(i);
            if (s > best_score) {
                best_score = s;
                x = 3;
                y = i;
            }
        }

        s = eval_enhclick();
        if (s > best_score) {
            best_score = s;
            x = 4;
        }

        return make_pair(x, y);
    }
};

bool operator<(const State& a, const State& b) {
    return a.state_score < b.state_score;
}


void init() {
    buy_cost[0][0] =  150;
    buy_cost[1][0] =  2000;
    buy_cost[2][0] =  30000;
    buy_cost[3][0] =  600000;
    buy_cost[4][0] =  10000000;
    rein_cost[0][0] = buy_cost[0][0] * 10;
    rein_cost[1][0] = buy_cost[1][0] * 10;
    rein_cost[2][0] = buy_cost[2][0] * 10;
    rein_cost[3][0] = buy_cost[3][0] * 10;
    rein_cost[4][0] = buy_cost[4][0] * 10;
    click_cost[0] = 15;

    REP(i, F) REP(j, MAXB-1) {
        buy_cost[i][j+1] = ceil(6.0 * buy_cost[i][j] / 5);
    }

    REP(i, F) REP(j, MAXB-1) {
        rein_cost[i][j+1] = 10 * rein_cost[i][j];
    }

    REP(j, MAXB-1) {
        click_cost[j+1] = click_cost[j] * 10;
    }


    HASH_P[0] = 1;
    REP(i, 10) {
        HASH_P[i+1] = HASH_P[i] * HASH_BASE;
    }


    int hoge;
    cin >> hoge >> STATUS;

    REP(i, N) if (STATUS[i] == 'F') {
        for (int j = i + 1; j <= i + 20 && j < N; ++j) {
            FEVER_A[j] = 1;
            FEVER_B[j] = 1;
        }
    }

    for (int i = N - 2; i >= 0; --i) {
        FEVER_B[i] += FEVER_B[i+1];
    }
}

void act(int x, int y) {
    cout << action[x];
    if (x >= 1 && x <= 3) {
        cout << " " << facility[y];
    }
    cout << endl;

    cin >> tmp;
    if (tmp != "ok") {
        exit(EXIT_FAILURE);
    }
}

void greedy_search() {
    State S;

    pair<int, int> p;
    int x, y;

    REP(_, N) {
        p = S.best_next_action();
        x = p.first;
        y = p.second;

        if (x == 0) {
            S.click();
        } else if (x == 1) {
            S.buy(y);
        } else if (x == 2) {
            S.sell(y);
        } else if (x == 3) {
            S.reinforce(y);
        } else {
            S.enhclick();
        }

        act(x, y);
    }
}

void beam_search() {
    State S, T;
    priority_queue<State> pq[2];
    pq[0].push(S);

    int id = -1;
    int cur = 0, tar = 1;

    for (int t = 0; t < N; ++t) {
        pq[tar] = priority_queue<State>();
        unordered_set<uint64_t> st;

        for (int k = 0; k < BEAM_WIDTH && !pq[cur].empty(); ++k) {
            S = pq[cur].top();
            pq[cur].pop();

            if (st.find(S.hash) != st.end()) {
                k -= 1;
                continue;
            }
            st.insert(S.hash);

            if (BONUS + 1 == t) {
                S.cookies += ceil(1.0 * S.cookies / 100);
            }

            id += 1;
            prev_id[id] = S.parent_id;
            prev_action[id] = S.parent_action;

            T = S;
            T.parent_id = id;

            T.click();
            T.state_score = T.eval();
            T.parent_action = 0;
            pq[tar].push(T);
            T.click_back();

            for (int f = 0; f < F; ++f) {
                if (T.buy(f)) {
                    T.state_score = T.eval();
                    T.parent_action = 10 + f;
                    pq[tar].push(T);
                    T.buy_back(f);
                }
            }

            /*
            for (int f = 0; f < F; ++f) {
                if (T.sell(f)) {
                    T.state_score = T.eval();
                    T.parent_action = 20 + f;
                    pq[tar].push(T);
                    T.sell_back(f);
                }
            }
            */

            for (int f = 0; f < F; ++f) {
                if (T.reinforce(f)) {
                    T.state_score = T.eval();
                    T.parent_action = 30 + f;
                    pq[tar].push(T);
                    T.reinforce_back(f);
                }
            }

            if (T.enhclick()) {
                T.state_score = T.eval();
                T.parent_action = 40;
                pq[tar].push(T);
                T.enhclick_back();
            }
        }

        if (STATUS[t] == 'B') {
            BONUS = t;
        } else if (STATUS[t] == 'F') {
            FEVER = t;
        } else if (STATUS[t] == 'S') {
            SALE = t;
        }

        cur ^= 1;
        tar ^= 1;
    }

    State last = pq[cur].top();
    vector<int> actions = {last.parent_action};
    id = last.parent_id;
    //cerr << last.cookies << endl;

    while (prev_action[id] != -1) {
        actions.push_back(prev_action[id]);
        id = prev_id[id];
    }

    reverse(actions.begin(), actions.end());

    int fc[5] = {0, 0, 0, 0, 0};
    REP(i, N) if (actions[i] / 10 == 1) {
        fc[actions[i] % 10] += 1;
    }

    int last_spent = 0;
    REP(i, N) if (actions[i] / 10 == 1 || actions[i] / 10 == 3 || actions[i] == 4) {
        last_spent = i;
    }
    REP2(i, last_spent+1, N) {
        actions[i] = 0;
    }

    for (int i = N - 1, f = 4; i > last_spent; ) {
        while (f >= 0 && fc[f] == 0) {
            f -= 1;
        }
        if (f < 0) {
            break;
        }

        uint64_t harvest =
            (N - i) *
            productivity[f] *
            (((uint64_t)(1)) << last.facility_level[f]);
        uint64_t selling_price = ceil(buy_cost[f][fc[f]-1] / 4.0);
        if (harvest < selling_price) {
            fc[f] -= 1;
            actions[i] = 20 + f;
            i -= 1;
        } else {
            f -= 1;
        }
    }

    for (int i = 0; i < N; ++i) {
        int x = actions[i] / 10;
        int y = actions[i] % 10;
        act(x, y);
    }
}

int main() {
    init();
    beam_search();
}


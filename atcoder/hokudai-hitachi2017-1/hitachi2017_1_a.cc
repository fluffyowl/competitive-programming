#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
 
 
//------------------------------------------------------------------------------
const long long int CYCLE_PER_SEC = 2800000000;
 
unsigned long long int getCycle()
{
  unsigned int low, high;
  __asm__ volatile ("rdtsc" : "=a" (low), "=d" (high));
  return ((unsigned long long int)low) | ((unsigned long long int)high << 32);
}
 
double getTime(unsigned long long int begin_cycle)
{
  return (double)(getCycle() - begin_cycle) / CYCLE_PER_SEC;
}
 
unsigned long long int startCycle = getCycle();
//------------------------------------------------------------------------------
 
 
const int INF = 1 << 29;
const int V_MAX = 550;
const int VEMB_MAX = 4000;
 
int V, E, Vemb, Eemb;
int edges_mat[V_MAX][V_MAX];
vector<pair<int, int> > edges_lst[V_MAX];
bool emb_edges_mat[VEMB_MAX][VEMB_MAX];
vector<int> emb_edges_lst[VEMB_MAX];
 
int perm[VEMB_MAX];
int ans[V_MAX];
int ans_rev[VEMB_MAX];
int best_ans[V_MAX];
bool used[VEMB_MAX];
bool incl[VEMB_MAX];
 
mt19937 mt(5000);
 
 
void input() {
    cin.tie(0); ios::sync_with_stdio(false);
 
    cin >> V >> E;
    for (int i = 0; i < E; ++i) {
        int u, v, c;
        cin >> u >> v >> c;
        edges_mat[u-1][v-1] = c;
        edges_mat[v-1][u-1] = c;
        edges_lst[u-1].push_back({v-1, c});
        edges_lst[v-1].push_back({u-1, c});
    }
 
    cin >> Vemb >> Eemb;
    for (int i = 0; i < Eemb; ++i) {
        int u, v;
        cin >> u >> v;
        emb_edges_mat[u-1][v-1] = true;
        emb_edges_mat[v-1][u-1] = true;
        emb_edges_lst[u-1].push_back(v-1);
        emb_edges_lst[v-1].push_back(u-1);
    }
}
 
 
 
int eval_swap(int u, int v) {
    int old_score = 0;
    int new_score = 0;
 
    if (u < V) {
        for (auto e: edges_lst[u]) {
            int uu = e.first;
            int c = e.second;
            if (emb_edges_mat[perm[u]][perm[uu]])
                old_score += c;
            if (emb_edges_mat[perm[v]][perm[uu]])
                new_score += c;
        }
    }
 
    if (v < V) {
        for (auto e: edges_lst[v]) {
            int vv = e.first;
            int c = e.second;
            if (emb_edges_mat[perm[v]][perm[vv]])
                old_score += c;
            if (emb_edges_mat[perm[u]][perm[vv]])
                new_score += c;
        }
    }
 
    return new_score - old_score;
}
 
 
void greedy_search() {
    int best_score = 0;
    int centernode = Vemb%2 ? Vemb/2 : Vemb/2 + (int)sqrt(Vemb) / 2;
 
    for (int center = V-1; center >= 0; --center) {
        if (getTime(startCycle) > 4.0)
            break;
 
        vector<int> nodes = vector<int>(V, 0);
        for (int i = 0; i < V; ++i) nodes[i] = i;
        memset(ans, 0, sizeof(ans));
        memset(ans_rev, 0, sizeof(ans_rev));
        memset(used, 0, sizeof(used));
        memset(incl, 0, sizeof(incl));
        vector<int> frontier;
        int score = 0;
 
        swap(nodes[center], nodes[nodes.size()-1]);
        nodes.pop_back();
        ans[center] = centernode;
        for (int i = 0; i < Vemb; ++i) ans_rev[i] = -1;
        used[centernode] = true;
        for (auto v: emb_edges_lst[centernode]) {
            frontier.push_back(v);
            incl[v] = true;
        }
 
        for (int x = 0; x < V-1; ++x) {
            int best_i = -1;
            int best_diff = -1;
            int best_f = -1;
            for (int i = 0; i < nodes.size(); ++i) {
                for (int f = 0; f < frontier.size(); ++f) {
                    int diff = 0;
                    for (auto g: emb_edges_lst[frontier[f]]) {
                        if (ans_rev[g] >= 0) {
                            diff += edges_mat[nodes[i]][ans_rev[g]];
                        }
                    }
                    if (diff > best_diff) {
                        best_diff = diff;
                        best_i = i;
                        best_f = f;
                    }
                }
            }
 
 
            ans[nodes[best_i]] = frontier[best_f];
            ans_rev[frontier[best_f]] = nodes[best_i];
            used[frontier[best_f]] = true;
            score += best_diff;
 
            for (auto j: emb_edges_lst[frontier[best_f]])
                if (!used[j] && !incl[j])
                    frontier.push_back(j), incl[j] = true;
 
            swap(nodes[best_i], nodes[nodes.size()-1]);
            nodes.pop_back();
            swap(frontier[best_f], frontier[frontier.size()-1]);
            frontier.pop_back();
        }
 
        if (score > best_score) {
            best_score = score;
            for (int i = 0; i < V; ++i) {
                best_ans[i] = ans[i];
            }
        }
    }
}
 
 
void hill_climbing() {
    memset(used, 0, sizeof(used));
    memset(perm, 0, sizeof(perm));
    uniform_int_distribution<int> rndv(0, V-1);
    uniform_int_distribution<int> rndemb(0, Vemb-1);
    uniform_real_distribution<double> rndp(0, 1);
 
    for (int i = 0; i < V; ++i) {
        perm[i] = best_ans[i];
        used[best_ans[i]] = true;
    }
 
    for (int i = V, p = 0; i < Vemb; ++i) {
        while (used[p]) ++p;
        perm[i] = p++;
    }

    shuffle(perm, perm+V, mt);
 
    int best_score = 0;
    int current_score = 0;
    const double sa_start_time = getTime(startCycle);
    const double sa_end_time = 11.5;
    double sa_current_time;
 
    while ((sa_current_time = getTime(startCycle)) < 9.9) {
        int u = rndv(mt);        
        int v = rndemb(mt);
        int diff = eval_swap(u, v);
 
        const double T = sa_end_time - sa_start_time;
        const double t = sa_current_time - sa_start_time;
        const double start_temp = 4.0;
        const double end_temp = 0.1;
        const double temp = start_temp + (end_temp - start_temp) * t / T;
        const double probability = exp(diff / temp);
        const bool FORCE_NEXT = probability > rndp(mt);
        
        if (diff >= 0 || FORCE_NEXT) {
            swap(perm[u], perm[v]);
            current_score += diff;
        }
 
        if (current_score > best_score) {
            best_score = current_score;
            for (int i = 0; i < V; ++i) {
                best_ans[i] = perm[i];
            }
        }
    }
}
 
 
int main() {
    input();
    greedy_search();
    hill_climbing();
 
    for (int i = 0; i < V; ++i)
        cout << i+1 << " " << best_ans[i]+1 << "\n";
 
    return 0;
} #include <bits/stdc++.h>
using namespace std;
typedef long long ll;
 
 
//------------------------------------------------------------------------------
const long long int CYCLE_PER_SEC = 2800000000;
 
unsigned long long int getCycle()
{
  unsigned int low, high;
  __asm__ volatile ("rdtsc" : "=a" (low), "=d" (high));
  return ((unsigned long long int)low) | ((unsigned long long int)high << 32);
}
 
double getTime(unsigned long long int begin_cycle)
{
  return (double)(getCycle() - begin_cycle) / CYCLE_PER_SEC;
}
 
unsigned long long int startCycle = getCycle();
//------------------------------------------------------------------------------
 
 
const int INF = 1 << 29;
const int V_MAX = 550;
const int VEMB_MAX = 4000;
 
int V, E, Vemb, Eemb;
int edges_mat[V_MAX][V_MAX];
vector<pair<int, int> > edges_lst[V_MAX];
bool emb_edges_mat[VEMB_MAX][VEMB_MAX];
vector<int> emb_edges_lst[VEMB_MAX];
 
int perm[VEMB_MAX];
int ans[V_MAX];
int ans_rev[VEMB_MAX];
int best_ans[V_MAX];
bool used[VEMB_MAX];
bool incl[VEMB_MAX];
 
mt19937 mt(5000);
 
 
void input() {
    cin.tie(0); ios::sync_with_stdio(false);
 
    cin >> V >> E;
    for (int i = 0; i < E; ++i) {
        int u, v, c;
        cin >> u >> v >> c;
        edges_mat[u-1][v-1] = c;
        edges_mat[v-1][u-1] = c;
        edges_lst[u-1].push_back({v-1, c});
        edges_lst[v-1].push_back({u-1, c});
    }
 
    cin >> Vemb >> Eemb;
    for (int i = 0; i < Eemb; ++i) {
        int u, v;
        cin >> u >> v;
        emb_edges_mat[u-1][v-1] = true;
        emb_edges_mat[v-1][u-1] = true;
        emb_edges_lst[u-1].push_back(v-1);
        emb_edges_lst[v-1].push_back(u-1);
    }
}
 
 
 
int eval_swap(int u, int v) {
    int old_score = 0;
    int new_score = 0;
 
    if (u < V) {
        for (auto e: edges_lst[u]) {
            int uu = e.first;
            int c = e.second;
            if (emb_edges_mat[perm[u]][perm[uu]])
                old_score += c;
            if (emb_edges_mat[perm[v]][perm[uu]])
                new_score += c;
        }
    }
 
    if (v < V) {
        for (auto e: edges_lst[v]) {
            int vv = e.first;
            int c = e.second;
            if (emb_edges_mat[perm[v]][perm[vv]])
                old_score += c;
            if (emb_edges_mat[perm[u]][perm[vv]])
                new_score += c;
        }
    }
 
    return new_score - old_score;
}
 
 
void greedy_search() {
    int best_score = 0;
    int centernode = Vemb%2 ? Vemb/2 : Vemb/2 + (int)sqrt(Vemb) / 2;
 
    for (int center = V-1; center >= 0; --center) {
        if (getTime(startCycle) > 4.0)
            break;
 
        vector<int> nodes = vector<int>(V, 0);
        for (int i = 0; i < V; ++i) nodes[i] = i;
        memset(ans, 0, sizeof(ans));
        memset(ans_rev, 0, sizeof(ans_rev));
        memset(used, 0, sizeof(used));
        memset(incl, 0, sizeof(incl));
        vector<int> frontier;
        int score = 0;
 
        swap(nodes[center], nodes[nodes.size()-1]);
        nodes.pop_back();
        ans[center] = centernode;
        for (int i = 0; i < Vemb; ++i) ans_rev[i] = -1;
        used[centernode] = true;
        for (auto v: emb_edges_lst[centernode]) {
            frontier.push_back(v);
            incl[v] = true;
        }
 
        for (int x = 0; x < V-1; ++x) {
            int best_i = -1;
            int best_diff = -1;
            int best_f = -1;
            for (int i = 0; i < nodes.size(); ++i) {
                for (int f = 0; f < frontier.size(); ++f) {
                    int diff = 0;
                    for (auto g: emb_edges_lst[frontier[f]]) {
                        if (ans_rev[g] >= 0) {
                            diff += edges_mat[nodes[i]][ans_rev[g]];
                        }
                    }
                    if (diff > best_diff) {
                        best_diff = diff;
                        best_i = i;
                        best_f = f;
                    }
                }
            }
 
 
            ans[nodes[best_i]] = frontier[best_f];
            ans_rev[frontier[best_f]] = nodes[best_i];
            used[frontier[best_f]] = true;
            score += best_diff;
 
            for (auto j: emb_edges_lst[frontier[best_f]])
                if (!used[j] && !incl[j])
                    frontier.push_back(j), incl[j] = true;
 
            swap(nodes[best_i], nodes[nodes.size()-1]);
            nodes.pop_back();
            swap(frontier[best_f], frontier[frontier.size()-1]);
            frontier.pop_back();
        }
 
        if (score > best_score) {
            best_score = score;
            for (int i = 0; i < V; ++i) {
                best_ans[i] = ans[i];
            }
        }
    }
}
 
 
void hill_climbing() {
    memset(used, 0, sizeof(used));
    memset(perm, 0, sizeof(perm));
    uniform_int_distribution<int> rndv(0, V-1);
    uniform_int_distribution<int> rndemb(0, Vemb-1);
    uniform_real_distribution<double> rndp(0, 1);
 
    for (int i = 0; i < V; ++i) {
        perm[i] = best_ans[i];
        used[best_ans[i]] = true;
    }
 
    for (int i = V, p = 0; i < Vemb; ++i) {
        while (used[p]) ++p;
        perm[i] = p++;
    }

    shuffle(perm, perm+V, mt);
 
    int best_score = 0;
    int current_score = 0;
    const double sa_start_time = getTime(startCycle);
    const double sa_end_time = 11.5;
    double sa_current_time;
 
    while ((sa_current_time = getTime(startCycle)) < 9.9) {
        int u = rndv(mt);        
        int v = rndemb(mt);
        int diff = eval_swap(u, v);
 
        const double T = sa_end_time - sa_start_time;
        const double t = sa_current_time - sa_start_time;
        const double start_temp = 4.0;
        const double end_temp = 0.1;
        const double temp = start_temp + (end_temp - start_temp) * t / T;
        const double probability = exp(diff / temp);
        const bool FORCE_NEXT = probability > rndp(mt);
        
        if (diff >= 0 || FORCE_NEXT) {
            swap(perm[u], perm[v]);
            current_score += diff;
        }
 
        if (current_score > best_score) {
            best_score = current_score;
            for (int i = 0; i < V; ++i) {
                best_ans[i] = perm[i];
            }
        }
    }
}
 
 
int main() {
    input();
    greedy_search();
    hill_climbing();
 
    for (int i = 0; i < V; ++i)
        cout << i+1 << " " << best_ans[i]+1 << "\n";
 
    return 0;
}

#include <iostream>
#include <vector>
#include <algorithm>
#include <iterator>
#include <map>
#include <tuple>
using namespace std;

vector<int> b (6);
vector<int> c (9);

pair<int, int> evaluate(vector<int> &board) {
  pair<int, int> result(0, 0);
  int i;
  for (i = 0; i < 6; i++) {
    if (board[i] == board[i+3]) result.first += b[i];
    else result.second += b[i];
  }
  for (auto i: {0, 1, 3, 4, 6, 7}) {
    if (board[i] == board[i+1]) result.first += c[i];
    else result.second += c[i];
  }
  return result;
}

pair<int, int> rec(vector<int> &board, int depth) {
  if (depth == 9) return evaluate(board);
  int i, a, b;
  int turn = depth % 2;
  vector<pair<int, int> > scores;
  vector<int> new_board(9);
  for (i = 0; i < 9; i++) {
    if (board[i] == -1) {
      copy(board.begin(), board.end(), new_board.begin());
      new_board[i] = turn;
      tie(a, b) = rec(new_board, depth+1);
      scores.push_back(make_pair(a, b));
    }
  }

  int max = 0;
  int max_i;
  if (turn == 0) {
    for (i = 0; i < (int)scores.size(); i++) {
      if (max <= scores[i].first) {
	max = scores[i].first;
	max_i = i;
      }
    }
  }
  else if (turn == 1) {
    for (i = 0; i < (int)scores.size(); i++) {
      if (max <= scores[i].second) {
	max = scores[i].second;
	max_i = i;
      }
    }
  }
  return scores[max_i];
}

int main(){
  int i;
  for (i = 0; i < 6; i++)
    cin >> b[i];
  for (auto i: {0, 1, 3, 4, 6, 7})
    cin >> c[i];

  vector<int> v(9, -1);
  int sente, gote;
  tie(sente, gote) = rec(v, 0);
  cout << sente << endl;
  cout << gote << endl;
  return 0;
}

#include <iostream>
#include <vector>
#include <algorithm>
#include <string>
using namespace std;

class BinaryTree {
public:
  int val;
  BinaryTree *left;
  BinaryTree *right;
  string str_t();
  BinaryTree(int val);
  ~BinaryTree();
};

BinaryTree::BinaryTree(int val) {
  this->left = nullptr;
  this->right = nullptr;
  this->val = val;
}

BinaryTree::~BinaryTree() {}

string BinaryTree::str_t() {
  string left, right;
  if (this->left == nullptr) left = "()";
  else left = "(" + this->left->str_t() +")";
  if (this->right == nullptr) right = "()";
  else right = "(" + this->right->str_t() + ")";
  return left + "[" + to_string(this->val) + "]" + right;
}

BinaryTree *parse(string s, int left, int right) {
  int c = 0;
  for (int i = left; i <= right; i++) {
    if (s[i] == '(') c++;
    else if (s[i] == ')') c--;
    else if (s[i] == '[' && c==0) {
      int num1 = i;
      while (s[i] != ']') i++;
      int num2 = i;
      int val = atoi(s.substr(num1+1, num2-num1-1).c_str());
      BinaryTree *new_t = new BinaryTree(val);
      if (s[num1-2] != '(' || s[num1-1] != ')')
	new_t->left = parse(s, left+1, num1-2);
      if (s[num2+1] != '(' || s[num2+2] != ')')
	new_t->right = parse(s, num2+2, right-1);
      return new_t;
    }
  }
}

BinaryTree *marge(BinaryTree *t1, BinaryTree *t2){
  BinaryTree *new_t = new BinaryTree(t1->val + t2->val);
  if (t1->left != nullptr && t2->left != nullptr)
    new_t->left = marge(t1->left, t2->left);
  if (t1->right != nullptr && t2->right != nullptr)
    new_t->right = marge(t1->right, t2->right);
  return new_t;
}

int main() {
  string A, B;
  cin >> A >> B;
  BinaryTree *a = parse(A, 0, A.size()-1);
  BinaryTree *b = parse(B, 0, B.size()-1);
  BinaryTree *c = marge(a, b);
  cout << c->str_t() << endl;
  return 0;
}

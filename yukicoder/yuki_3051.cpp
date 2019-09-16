#include <bits/stdc++.h>
//#include <bits/stdc++.h>
//#include <bits/stdc++.h>
using namespace std;
//using namespace std;
//using namespace std;
void ans(int p,char a,char b) {
//void ans(int p,char a,char b) {
//void ans(int p,char a,char b) {
cout << p << endl << "\"" << a << "\"" << endl << "\"" << b << "\"" << endl;
//cout << p << endl << "\"" << a << "\"" << endl << "\"" << b << "\"" << endl;
//cout << p << endl << "\"" << a << "\"" << endl << "\"" << b << "\"" << endl;
}
//}
//}
int main() {
//int main() {
//int main() {
int p = 0;
//int p = 0;
//int p = 0;
string s1, s2, s3;
//string s1, s2, s3;
//string s1, s2, s3;
for (int j = 0; j < 38; ++j) {
//for (int j = 0; j < 38; ++j) {
//for (int j = 0; j < 38; ++j) {
getline(cin, s1);
//getline(cin, s1);
//getline(cin, s1);
getline(cin, s2);
//getline(cin, s2);
//getline(cin, s2);
getline(cin, s3);
//getline(cin, s3);
//getline(cin, s3);
int n = s1.size() + 1;
//int n = s1.size() + 1;
//int n = s1.size() + 1;
if (s2[0] != '/') {
//if (s2[0] != '/') {
//if (s2[0] != '/') {
ans(p + n, '/', s2[0]);
//ans(p + n, '/', s2[0]);
//ans(p + n, '/', s2[0]);
}
//}
//}
if (s2[1] != '/') {
//if (s2[1] != '/') {
//if (s2[1] != '/') {
ans(p + n + 1, '/', s2[1]);
//ans(p + n + 1, '/', s2[1]);
//ans(p + n + 1, '/', s2[1]);
}
//}
//}
if (s3[0] != '/') {
//if (s3[0] != '/') {
//if (s3[0] != '/') {
ans(p + n + 2 + n, '/', s3[0]);
//ans(p + n + 2 + n, '/', s3[0]);
//ans(p + n + 2 + n, '/', s3[0]);
}
//}
//}
if (s3[1] != '/') {
//if (s3[1] != '/') {
//if (s3[1] != '/') {
ans(p + n + 2 + n + 1, '/', s3[1]);
//ans(p + n + 2 + n + 1, '/', s3[1]);
//ans(p + n + 2 + n + 1, '/', s3[1]);
}
//}
//}
for (int i = 0; i < (int)s1.size(); ++i) {
//for (int i = 0; i < (int)s1.size(); ++i) {
//for (int i = 0; i < (int)s1.size(); ++i) {
if (s1[i] == s2[i+2] && s1[i] != s3[i+2]) {
//if (s1[i] == s2[i+2] && s1[i] != s3[i+2]) {
//if (s1[i] == s2[i+2] && s1[i] != s3[i+2]) {
ans(p + n + 2 + n + 2 + i, s1[i], s3[i+2]);
//ans(p + n + 2 + n + 2 + i, s1[i], s3[i+2]);
//ans(p + n + 2 + n + 2 + i, s1[i], s3[i+2]);
} else if (s1[i] == s3[i+2] && s1[i] != s2[i+2]) {
//} else if (s1[i] == s3[i+2] && s1[i] != s2[i+2]) {
//} else if (s1[i] == s3[i+2] && s1[i] != s2[i+2]) {
ans(p + n + 2 + i, s1[i], s2[i+2]);
//ans(p + n + 2 + i, s1[i], s2[i+2]);
//ans(p + n + 2 + i, s1[i], s2[i+2]);
} else if (s2[i+2] == s3[i+2] && s1[i] != s2[i+2]) {
//} else if (s2[i+2] == s3[i+2] && s1[i] != s2[i+2]) {
//} else if (s2[i+2] == s3[i+2] && s1[i] != s2[i+2]) {
ans(p + i, s2[i+2], s1[i]);
//ans(p + i, s2[i+2], s1[i]);
//ans(p + i, s2[i+2], s1[i]);
}
//}
//}
}
//}
//}
p += n + 2 + n + 2 + n;
//p += n + 2 + n + 2 + n;
//p += n + 2 + n + 2 + n;
}
//}
//}
getline(cin, s1);
//getline(cin, s1);
//getline(cin, s1);
}
//}
//}


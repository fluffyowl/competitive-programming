#include <iostream>
#include <math.h>
#include <vector>
#include <iomanip>
#include <stdio.h>
using namespace std;

int main() {
  int M;
  cin >> M;
  int M2 = (int)pow(2, M);
  double R[1024];
  for (int i = 0; i < M2; i++)
    cin >> R[i];
  vector<vector<double> > shouhai;
  shouhai = vector<vector<double> >(1024, vector<double>(1024, 0));
  for (int i = 0; i < M2; i++)
    for (int j = 0; j < M2; j++) 
      shouhai[i][j] = 1.0 / (1.0+pow(10, (R[j]-R[i])/400.0));

  double dp[12][1024] = {};
  for (int i = 0; i < M2; i++)
    dp[0][i] = 1;

  for (int i = 1; i < M+2; i++)
    for (int j = 0; j < M2; j++)
      for (int k = 0; k < M2; k++)
	if ((j^k) >> (i-1) == 1)
	  dp[i][j] += dp[i-1][j] * dp[i-1][k] * shouhai[j][k];

  for (int i = 0; i < M2; i++)
    printf("%.08f\n", dp[M][i]);
  return 0;
}

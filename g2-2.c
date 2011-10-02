#include <stdio.h>

int collatz(int n) {
  if(n == 1) {
    return 0;
  } else if(n%2 == 0) {
    n = n/2;
  } else {
    n = 3*n+1;
  }
  return 1 + collatz(n);
}

int longest_path(int limit) {
  int max_length = 0;
  int max_n = -1;
  int n;
  for(n=1; n<limit; n++) {
    int length = collatz(n);
    if(length > max_length) {
      max_length = length;
      max_n = n;
    }
  }
  printf("n:%i, length:%i\n", max_n, max_length);
}

int main(){
  longest_path(10);
  longest_path(50);
}


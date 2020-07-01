#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
IntegerVector fibcpp(int n, int f0 = 0, int f1 = 1) {
  
  if (n < 0) {
    return IntegerVector::create(-1);
  } else {
    IntegerVector ans0 = fibcpp(n-1, f1, f0 + f1);
    ans0.push_front(f0 + f1);
    return ans0;
  }
  
}

/*** R
fib1 <- function(n, f0 = 0, f1 = 1) {
  
  if (n < 0)
    return(NULL)
  else {
    return(c(f0 + f1, fib1(n - 1, f1, f0 + f1)))
  }
  
}

microbenchmark::microbenchmark(
  fib1(100),
  fibcpp(100), unit = "relative"
)
*/
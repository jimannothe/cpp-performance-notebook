#include <chrono>
#include <cstdint>
#include <iostream>
#include <vector>

// Simple hot loop for build and timing smoke checks.
int main() {
  constexpr std::size_t n = 1'000'000;
  std::vector<std::uint64_t> v;
  v.reserve(n);
  for (std::size_t i = 0; i < n; ++i) v.push_back(i);

  auto t0 = std::chrono::high_resolution_clock::now();
  std::uint64_t sum = 0;
  for (auto x : v) sum += x;
  auto t1 = std::chrono::high_resolution_clock::now();

  auto us = std::chrono::duration_cast<std::chrono::microseconds>(t1 - t0).count();
  std::cout << "sum=" << sum << " time_us=" << us << "\n";
  return 0;
}

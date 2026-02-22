#include <chrono>
#include <cstdint>
#include <iostream>
#include <utility>

using Clock = std::chrono::steady_clock;

struct Payload {
  static inline std::uint64_t copies = 0;
  static inline std::uint64_t moves = 0;

  int data[256]{};

  Payload() = default;

  Payload(const Payload& other) {
    for (int i = 0; i < 256; ++i) {
      data[i] = other.data[i];
    }
    ++copies;
  }

  Payload(Payload&& other) noexcept {
    for (int i = 0; i < 256; ++i) {
      data[i] = other.data[i];
    }
    ++moves;
  }
};

volatile std::uint64_t sink = 0;

inline void consume(const Payload& p) { sink = sink + static_cast<std::uint64_t>(p.data[0]); }
inline void consume(Payload&& p) { sink = sink + static_cast<std::uint64_t>(p.data[1]); }

template <typename T>
inline void call_bad(T x) {
  consume(std::move(x));
}

template <typename T>
inline void call_good(T&& x) {
  consume(std::forward<T>(x));
}

template <typename F>
std::uint64_t run(F&& f, int n) {
  Payload value{};
  value.data[0] = 1;
  value.data[1] = 2;

  Payload::copies = 0;
  Payload::moves = 0;

  const auto t0 = Clock::now();
  for (int i = 0; i < n; ++i) {
    f(value);
  }
  const auto t1 = Clock::now();

  const auto ns =
      static_cast<std::uint64_t>(std::chrono::duration_cast<std::chrono::nanoseconds>(t1 - t0).count());

  std::cout << "copies=" << Payload::copies << " moves=" << Payload::moves << " time_ns=" << ns << '\n';
  return ns;
}

int main() {
  constexpr int n = 1'000'000;
  std::cout << "n=" << n << '\n';

  std::cout << "call_bad with lvalue:  ";
  const auto bad = run([](auto& p) { call_bad(p); }, n);

  std::cout << "call_good with lvalue: ";
  const auto good = run([](auto& p) { call_good(p); }, n);

  if (good > 0) {
    std::cout << "bad/good ratio=" << (static_cast<double>(bad) / static_cast<double>(good)) << '\n';
  }
}

# 001 intro (book)

This will be a quick refresher on *C++*. Including previous and up to standard *C++20*.

Focus is to refresh the basics and get up to, performance optimization topics in general ASAP.

This is is also an interactive notebook vibe coded using ***Codex***.

The environment consists of Nvim set up for *C++* execution and parsing. 

Lessons are documented in markdown files. *C+* blocks can be embedded into the lesson, these *C++* blocks can be compiled and executed from the lesson itself. For this and other ***interactive*** functions the **cppnote** command has been created.


```cpp

//This Block was introduced with the CppNoteBlock nvim custom command
#include <iostream>
auto main() -> int {  
  std::cout << "Introducing old and new syntax -> \n";
}
```

- No need to explicitly state a **return** value.
  - Use of the trailing return type: **->** and **auto** keyword. To deduce the return type automatically.
- 


Lets look at the following code:


```cpp
// Type declarations and overload operator
#include <iostream>
#include <functional>
int main() {
 
  std::cout << "This is another, older way, of declaring a function\n And 2 different ways to add a value: \n";

  //Now lets add 2 variables, a float and an int

  std::cout << std::plus<int>{}(3.14,3) << "due to int declaration \n";

  std::cout << std::plus<>{}(3.14,3) << " due to int promotion \n";

  auto x = 3.14 +  3;

  std::cout << x << "\n";
//  std::cout << 

  return 0;
}
```


#2 DO

```cpp
#include <iostream>

auto main() -> int {
  // TODO: lesson code
  std::cout << "What will it be?\n"; 
}
```


**additional comments by rschatz**

Playing around with this a bit more, there are a few weird things here.

I added a `main.c` file, so we can test without GraalVM.
This main file does essentially the same thing as the `tester.java` file, but loading the libraries with regular `dlopen`/`dlsym` instead of the GraalVM APIs.

I have added makefiles that builds the test in multiple variants:

* managed
    The original test, compiled for the GraalVM LLVM runtime in managed mode.
* native
    Building the same test with the GraalVM shipped LLVM toolchain, but in native mode, so we can run it also outside of GraalVM.
* gcc
    For comparison, building the same thing just with gcc.

I modified the `run.sh` so it runs all of those variants.

Both the `Makefile` and `run.sh` expect the `GRAALVM_HOME` env variable to point to a GraalVM EE with the LLVM toolchain installed.



**Describe the issue**
The C++ `dynamic_cast` only works if the `dynamic_cast` is called from the same shared library that has the definition of `Base` class and `Derived` class. (all the code are located in the same shared
library).  On the other hand, if the `dynamic_cast` is called from another shared library (during linking process, this share library links the library with the real definition of classes),
`dynamic_cast` failed and returned the null pointer. 

**Steps to reproduce the issue**

1. `git clone https://github.com/changlun-adyen/graalvm-dynamic-cast-issue.git`
2. change the GraalVM toolchain path in `build.sh` 
3. execute `build.sh`
4. execute `run.sh` (make sure the env `JAVA_HOME` is set to GraalVM JDK)


**Describe GraalVM and your environment:**
 - GraalVM version: 22.1.0 EE 
 - JDK major version: JDK11 
 - OS: macOS Monterey 
 - Architecture: AMD64 

The output of java -Xinternalversion:
Java HotSpot(TM) 64-Bit Server VM (11.0.15+8-LTS-jvmci-22.1-b05) for bsd-amd64 JRE (11.0.15+8-LTS-jvmci-22.1-b05), built on Apr  4 2022 04:05:20 by "graal1" with gcc 4.2.1 Compatible Apple LLVM 11.0.0
(clang-1100.0.33.17)


**More details**
The below code failed at `dynamic_cast`, which should not happen no matter where the code is located.

```
#include <iostream>
#include "test.h"

extern "C" {

void test2() {
  Derived *ptr_derived = new Derived();
  Base *ptr_base = ptr_derived;

  auto* cast_ptr = dynamic_cast<Derived*>(ptr_base);
  if(cast_ptr) {
    std::cout <<  "ok" << std::endl;
  } else {
    std::cout <<  "failed at dynamic_cast" << std::endl;
  }
}

}
```


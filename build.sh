
#!/bin/sh
set -x 
# Note: change the toolchain path to your GraalVM path
GRAALVM_MANAGED_LLVM_TOOLCHAIN=/Users/changlun/tools/graalvm-ee-java11-22.1.0/Contents/Home/languages/llvm/managed/bin

# build the libtest.so
$GRAALVM_MANAGED_LLVM_TOOLCHAIN/clang++ -g -frtti -fPIC -shared test.cpp -O1 -o libtest.so 

# build the libtest2.so by linking libtest.so
$GRAALVM_MANAGED_LLVM_TOOLCHAIN/clang++ -g -frtti -fPIC -shared test2.cpp -L. -Wl,-ltest -O1 -o libtest2.so 

set +x

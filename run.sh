make

echo
echo "reference run (compiled with gcc and libstdc++)"
(
cd gcc
./main
)

echo
echo "reference run (compiled with clang and libc++, run without graalvm)"
(
cd native
LD_LIBRARY_PATH=$GRAALVM_HOME/languages/llvm/native/lib ./main
)

echo
echo "graalvm native mode, starting from C"
(
cd native
$GRAALVM_HOME/bin/lli ./main
)

echo
echo "graalvm native mode, starting from Java"
(
cd native
$GRAALVM_HOME/bin/java Tester
)


echo
echo "graalvm managed mode, starting from C"
(
cd managed
$GRAALVM_HOME/bin/lli --llvm.managed ./main
)

echo
echo "graalvm managed mode, starting from Java"
(
cd managed
$GRAALVM_HOME/bin/java Tester
)

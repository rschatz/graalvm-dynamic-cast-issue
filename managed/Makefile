TOOLCHAIN=$(shell ${GRAALVM_HOME}/bin/lli --llvm.managed --print-toolchain-path)
CC=${TOOLCHAIN}/clang
CXX=${TOOLCHAIN}/clang++

include ../Makefile.native

default: Tester.class

Tester.class: tester.java
	${GRAALVM_HOME}/bin/javac tester.java


# build the java test class
echo "JAVA PATH: $(which java) (expect: <GraalVM JDK install path>/graalvm-ee-java11-22.1.0/Contents/Home/bin/java)"
javac tester.java
java Tester

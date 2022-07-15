import java.io.*;
import org.graalvm.polyglot.*;
import java.lang.reflect.Method;
import java.util.*;
import java.lang.Thread;

class Tester {
    public static void main(String[] args) throws Exception {
        Context polyglot = Context.newBuilder().allowAllAccess(true).allowIO(true).option("llvm.managed", "false").build();

        // OK: the library `libtest.so` has the definition of class and we do the dynamic casting in the same library. 
        File file = new File("libtest.so");
        Source source = Source.newBuilder("llvm", file).build();
        final Value cpart = polyglot.eval(source);
        cpart.invokeMember("test");

        // FAIL: the library `libtest2.so` links the `libtest.so`, and we do the dynamic casting from `libtests2.so`
        File file2 = new File("libtest2.so");
        Source source2 = Source.newBuilder("llvm", file2).build();
        final Value cpart2 = polyglot.eval(source2);
        cpart2.invokeMember("test2");
    }
}

#include <dlfcn.h>
#include <stdio.h>

int main() {
    void *libtest = dlopen("./libtest.so", RTLD_LAZY);
    if (!libtest) {
        printf("libtest.so: %s\n", dlerror());
        return 1;
    }

    void (*test)() = dlsym(libtest, "test");
    test();

    void *libtest2 = dlopen("./libtest2.so", RTLD_LAZY);
    if (!libtest2) {
        printf("libtest2.so: %s\n", dlerror());
        return 1;
    }

    void (*test2)() = dlsym(libtest2, "test2");
    test2();

    return 0;
}

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

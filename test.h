struct Base {
  virtual void f() {};
  virtual ~Base();
};

struct Derived : public Base {
  // 1. (FAIL) providing the user-defined constructor makes the dynamic_cast failed
  Derived();
  virtual ~Derived();

  // 2. (FAIL) providing the user-defined overwritten function makes the dynamic_cast failed 
  //void f() override;

  // 3. (OK) Don't define anything in the class (without 1 & 2) makes the dynamic_cast succeeded 
};

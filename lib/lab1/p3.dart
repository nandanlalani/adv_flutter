class A {
  void display() {
    print("Hello from A");
  }
}

class B extends A {
  @override
  void display() {
    print("Hello from B");
  }
}

void main() {
  A a = A();
  a.display();

  B b = B();
  b.display();
}

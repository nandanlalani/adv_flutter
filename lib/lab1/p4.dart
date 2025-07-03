abstract class A {
  void display();
}

class B extends A {
  @override
  void display() {
    print('Darshan');
  }
}

class C extends A {
  @override
  void display() {
    print('University');
  }
}

void main() {
  A b = B();
  A c = C();

  b.display();
  c.display();
}
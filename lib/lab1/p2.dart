class A {
  String name;

  A(this.name);

  void display() {
    print('Hello $name');
  }
}

class B extends A {

  B(String name) : super(name);

  void display2() {
    print('Hi from $name');
  }
}

void main() {
  B b = B('Sheet');
  b.display();
  b.display2();
}
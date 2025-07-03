class Counter {
  static int count = 0;

  static void increment() {
    count = ++count;
  }
}

class A {
  void counter() {
    Counter.increment();
    print('A:::${Counter.count}');
  }
}

class B {
  void counter() {
    Counter.increment();
    print('B:::${Counter.count}');
  }
}

void main() {
  A a = A();
  B b = B();

  a.counter();
  b.counter();
  a.counter();
  b.counter();
  print(Counter.count);
}
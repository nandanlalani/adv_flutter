class Student {
  String name;
  int age;
  int rollNo;

  Student(this.name,this.age,this.rollNo);

  void displayDetails() {
    print('Student Details:');
    print('Name: $name');
    print('Age: $age');
    print('Roll No: $rollNo');
  }
}

void main() {
  Student student = Student('Sheet',20,391);
  student.displayDetails();
}
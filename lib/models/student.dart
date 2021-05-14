class Student {
  String studentId;
  String firstName;
  String lastName;

  Student({
    this.studentId,
    this.firstName,
    this.lastName,
  });

  factory Student.fromJson(Map<String, dynamic> responseData) {
    return Student(
        studentId: responseData['studentId'],
        firstName: responseData['firstName'],
        lastName: responseData['lastName']);
  }
}

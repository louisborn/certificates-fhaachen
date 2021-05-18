/// A model for a student object.
///
/// Each individual student should have a unique [studentId], a [firstName]
/// and a [lastName].
class Student {
  /// Creates a student object.
  ///
  /// The [studentId], [firstName] and [lastName] must not be null.
  Student({
    this.studentId,
    this.firstName,
    this.lastName,
  })  : assert(studentId != null),
        assert(firstName != null),
        assert(lastName != null);

  /// The unique [studentId].
  ///
  /// This is the unique identifier for a student.
  final String? studentId;

  final String? firstName;

  final String? lastName;

  /// Decodes a json response object to a [Student] object.
  ///
  factory Student.fromJson(Map<String, dynamic> data) {
    return Student(
        studentId: data['studentId'],
        firstName: data['firstName'],
        lastName: data['lastName']);
  }
}

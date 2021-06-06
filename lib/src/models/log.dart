/// A model for the log of a user activity.
///
class Log {
  /// Creates a log.
  ///
  const Log({
    required this.date,
    required this.enter,
    required this.leave,
    required this.studentId,
    required this.workspaceName,
  });

  /// The creation date of the log.
  final String? date;

  /// The enter time of a user.
  final String? enter;

  /// The leave time of a user.
  final String? leave;

  /// The unique id of a user.
  final String? studentId;

  /// The accessed workspace name.
  final String? workspaceName;

  /// Decodes a map object to a [Log] object.
  ///
  factory Log.fromMap(Map data) {
    return Log(
      date: data['date'],
      enter: data['enter'],
      leave: data['leave'],
      studentId: data['studentId'],
      workspaceName: data['workspaceName'],
    );
  }
}

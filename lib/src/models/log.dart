/// A model for a [Log] object.
///
class Log {
  /// Creates a [Log] object.
  ///
  /// The [date], [enter], [leave], [studentId] and
  /// [workspaceName] is required.
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

  /// Decodes a map data that is fetched from the API
  /// to an [Log] object.
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

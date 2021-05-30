class Log {
  Log({
    this.date,
    this.enter,
    this.leave,
    this.studentId,
    this.workspaceName,
  });

  final String? date;

  final String? enter;

  final String? leave;

  final String? studentId;

  final String? workspaceName;

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

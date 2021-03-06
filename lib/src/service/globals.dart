import 'package:certificates/models.dart';
import 'package:certificates/services.dart';

class Global {
  static final Map models = {
    Student: (data) => Student.fromJson(data),
    Certificate: (data) => Certificate.fromMap(data),
    Log: (data) => Log.fromMap(data),
    Campus: (data) => Campus.fromMap(data),
    Workspace: (data) => Workspace.fromMap(data),
    FAQ: (data) => FAQ.fromMap(data),
  };

  static final Collection<Certificate> certificatesRef =
      Collection<Certificate>(path: 'certificates');
}

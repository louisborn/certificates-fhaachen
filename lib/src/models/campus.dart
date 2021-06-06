/// A model for a campus.
///
class Campus {
  /// Creates a campus.
  ///
  const Campus({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.street,
    required this.postal,
    required this.city,
  });

  /// The unqiue id of a campus.
  final String? id;

  /// The name of a campus.
  final String? name;

  /// The phone number for a campus.
  final String? phone;

  /// The email address for a campus.
  final String? email;

  /// The address of a campus.
  final String? street;

  /// The address of a campus.
  final String? postal;

  /// The address of a campus.
  final String? city;

  /// Decodes a map data to a [Campus] object.
  ///
  factory Campus.fromMap(Map data) {
    return Campus(
      id: data['id'],
      name: data['name'],
      phone: data['phone'],
      email: data['email'],
      street: data['street'],
      postal: data['postal'],
      city: data['city'],
    );
  }
}

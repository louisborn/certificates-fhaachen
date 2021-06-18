/// A model for a [Campus] object.
///
class Campus {
  /// Creates a [Campus] object.
  ///
  /// The [id], [name], [street], [postal] and [city]
  /// is required.
  ///
  const Campus({
    required this.id,
    required this.name,
    this.phone,
    this.email,
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

  /// Decodes map data that is fetched from the API
  /// to a [Campus] object.
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

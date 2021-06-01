class Campus {
  Campus({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.street,
    this.postal,
    this.city,
  });

  final String? id;

  final String? name;

  final String? phone;

  final String? email;

  final String? street;

  final String? postal;

  final String? city;

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

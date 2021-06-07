/// A model for certificates.
///
class Certificate {
  /// Creates a certificate.
  const Certificate({
    required this.name,
    required this.description,
    required this.machine,
    required this.assignedTo,
    required this.safetyInstruction,
  })   : assert(name != null),
        assert(machine != null);

  /// The name of a certificate.
  final String? name;

  /// The description of a certificate.
  final String? description;

  /// The assigned machine for a certificate.
  final String? machine;

  /// The list of assigned students to a certificate.
  final List? assignedTo;

  /// The safety instruction for a certificate.
  final String? safetyInstruction;

  /// Decodes a map data to a [Certificate] object.
  ///
  factory Certificate.fromMap(Map data) {
    return Certificate(
      name: data["name"],
      description: data["description"],
      machine: data["machine"],
      assignedTo: data["assignedTo"],
      safetyInstruction: data["safetyInstruction"],
    );
  }
}

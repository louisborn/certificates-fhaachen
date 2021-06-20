/// A model for a [Certificate] object.
///
class Certificate {
  /// Creates a [Certificate] object.
  ///
  /// The [name], [description], [machine], [assignedTo] and
  /// [safetyInstruction] is required.
  ///
  const Certificate({
    required this.name,
    required this.description,
    required this.machine,
    required this.assignedTo,
    required this.safetyInstruction,
  })   : assert(name != null),
        assert(machine != null),
        assert(safetyInstruction != null);

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

  /// Decodes map data that if fecthed from the API
  /// to a [Certificate] object.
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

class Certificate {
  Certificate({
    this.name,
    this.description,
    this.machine,
    this.assignedTo,
    this.safetyInstruction,
  })  : assert(name != null),
        assert(machine != null);

  final String? name;

  final String? description;

  final String? machine;

  final List? assignedTo;

  final String? safetyInstruction;

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

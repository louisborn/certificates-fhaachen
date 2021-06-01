class Workspace {
  Workspace({
    this.name,
    this.currentInWorkspace,
    this.maxInWorkspace,
  });

  final String? name;

  final String? currentInWorkspace;

  final String? maxInWorkspace;

  factory Workspace.fromMap(Map data) {
    return Workspace(
      name: data['name'],
      currentInWorkspace: data['currentInWorkspace'],
      maxInWorkspace: data['maxInWorkspace'],
    );
  }
}

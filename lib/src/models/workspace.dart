class Workspace {
  Workspace({
    this.id,
    this.name,
    this.currentInWorkspace,
    this.maxInWorkspace,
    this.path = '',
  });

  final String? id;

  final String? name;

  final int? currentInWorkspace;

  final int? maxInWorkspace;

  final String path;

  factory Workspace.fromMap(Map data) {
    return Workspace(
      id: data['id'],
      name: data['name'],
      currentInWorkspace: data['currentInWorkspace'],
      maxInWorkspace: data['maxInWorkspace'],
    );
  }
}

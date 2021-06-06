/// A model for a workspace.
///
/// Each workspace has a unique [id] and a [name].
/// The [currentInWorkspace] and [maxInWorkspace] is used
/// to control the access of students to a workspace.
///
class Workspace {
  /// Creates a workspace.
  ///
  const Workspace({
    required this.id,
    required this.name,
    required this.currentInWorkspace,
    required this.maxInWorkspace,
    this.path = '',
  });

  /// The unique id of a workspace.
  final String? id;

  /// The workspace name.
  final String? name;

  /// The current user`s in a workspace.
  final int? currentInWorkspace;

  /// The maximal allowed user`s in a workspace.
  final int? maxInWorkspace;

  /// The optional path to the workspace data
  /// in the database.
  ///
  final String path;

  /// Decodes a map object to a [Workspace] object.
  ///
  factory Workspace.fromMap(Map data) {
    return Workspace(
      id: data['id'],
      name: data['name'],
      currentInWorkspace: data['currentInWorkspace'],
      maxInWorkspace: data['maxInWorkspace'],
    );
  }
}

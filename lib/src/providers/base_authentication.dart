/// A base class for the authentication service.
///
abstract class BaseAuthentication {
  /// Logs a user into the application.
  ///
  /// Throws an [Exception] if the credential validation
  /// fails or if the http request failed.
  ///
  Future<void> login(String id, String name);

  /// Logs a user out of the application.
  Future<void> logout(String id);

  /// Validates the user last name input.
  ///
  /// Returns `false` if the input name is not equal to
  /// the database name.
  ///
  bool validateLastName(String input, String lastName);

  /// Creates a two factor authentication token and patches
  /// it to the user`s data.
  ///
  /// Throws an [Exception] if the http request failed.
  ///
  Future<void> startAndPatch2fAToken();

  /// Initializes the two factor authentication process and
  /// returns the created token.
  ///
  String create2fAToken();

  /// Calculates a fifteen character long random number string
  /// and returns it as a [List].
  ///
  /// This random number is used to calculate the base64
  /// code.
  ///
  List calculateRndNumberChar();

  /// Calculates a base64 code based on the user` id, last name and
  /// the [rndChar].
  String calculateBase64Encode(var rndChar);

  /// Returns five random indices number between 0 and [base64str] length.
  ///
  /// This [Iterable] indices is used to pick the token from the generated
  /// [base64str].
  ///
  Iterable return5RandomIndices(var base64str);

  /// Returns the two factor authentication token.
  String returnAuthenticationToken(String base64str, Iterable rndChar);

  /// Validates the user`s input token.
  ///
  /// Throws an [Exception] if the token validation fails.
  ///
  Future<void> validate2fAToken(String token);
}

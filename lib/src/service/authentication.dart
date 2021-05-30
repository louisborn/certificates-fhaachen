import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:certificates/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../models.dart';

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
  Future<bool> logout();

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

/// Indicates the current authentication status for a user.
///
enum AuthenticationStatus {
  NotLoggedIn,
  LoggedIn,
  Authenticating,
  ReadyFor2fA,
  WaitingFor2fAToken,
}

/// Indicates how to handle authentication errors.
///
enum AuthenticationError {
  NoError,
  Error,
  Exception,
}

/// A service to provide an login and two factor authentication to
/// a user.
///
/// The service consists of an [login] and [createAndPatch2fAToken].
///
/// The [login] validates the users input. Throws an [SocketException] in an
/// case of an network error. Throws an [Exception] if the [_studentId] or
/// [_lastName] fails to validate.
///
class AuthenticationService extends ChangeNotifier
    implements BaseAuthentication {
  /// A text containing the current exception that occurred.
  ///
  late String exception;

  /// A value containing the unique student id.
  ///
  late String _studentId;

  /// A value containing the name of a user.
  ///
  late String _firstName;

  /// A value containing the last name of a user.
  ///
  late String _lastName;

  /// A random character sequence used in the two factor authentication.
  ///
  late String _token;

  /// Sets the value of the student id.
  ///
  set studentId(String? id) => this._studentId = id!;

  /// Sets the value of the user name.
  ///
  set firstName(String? name) => this._firstName = name!;

  /// Sets the value of the user last name.
  ///
  set lastName(String? name) => this._lastName = name!;

  /// Getter and setter for the current [AuthenticationError].
  ///
  AuthenticationError get authenticationError => _authenticationError;
  AuthenticationError _authenticationError = AuthenticationError.NoError;

  /// Getter and setter for the current [AuthenticationStatus] of a user.
  ///
  AuthenticationStatus get loggedInStatus => _loggedInStatus;
  AuthenticationStatus _loggedInStatus = AuthenticationStatus.NotLoggedIn;

  @override
  Future<void> login(String id, String name) async {
    setAuthenticationStatus(AuthenticationStatus.Authenticating);
    try {
      final http.Response response = await http.get(
        Uri.parse("$api$id.json"),
      );

      if (response.statusCode == 200) {
        Student _student = createStudentModel(response);
        if (validateLastName(name, _student.lastName!)) {
          studentId = _student.studentId;
          lastName = _student.lastName;
          firstName = _student.firstName;
          await startAndPatch2fAToken();

          setAuthenticationStatus(AuthenticationStatus.ReadyFor2fA);
        } else {
          catchAnyException(AuthenticationError.Exception,
              "Student id or last name is incorrect");
          setAuthenticationStatus(AuthenticationStatus.NotLoggedIn);
        }
      } else {
        catchAnyException(
          AuthenticationError.Exception,
          response.statusCode.toString(),
        );
        setAuthenticationStatus(AuthenticationStatus.NotLoggedIn);
      }
    } catch (exception) {
      if (e is SocketException) {
        catchAnyException(
          AuthenticationError.Exception,
          e.toString(),
        );
        setAuthenticationStatus(AuthenticationStatus.NotLoggedIn);
      } else {
        catchAnyException(
          AuthenticationError.Exception,
          exception.toString(),
        );
        setAuthenticationStatus(AuthenticationStatus.NotLoggedIn);
      }
    }
  }

  Student createStudentModel(http.Response response) {
    Student _student = Student.fromJson(
      jsonDecode(response.body),
    );
    return _student;
  }

  @override
  bool validateLastName(String input, String lastName) {
    return input == lastName ? true : false;
  }

  @override
  Future<bool> logout() async {
    if (await PreferenceService().clearAll()) return true;
    return false;
  }

  @override
  Future<void> startAndPatch2fAToken() async {
    this._token = create2fAToken();
    try {
      final http.Response response = await http.patch(
        Uri.parse("$api$_studentId.json"),
        body: jsonEncode(
          {"token": _token},
        ),
      );
      if (response.statusCode == 200) {
        setAuthenticationStatus(AuthenticationStatus.WaitingFor2fAToken);
      } else {
        catchAnyException(
          AuthenticationError.Exception,
          response.statusCode.toString(),
        );
        setAuthenticationStatus(AuthenticationStatus.NotLoggedIn);
      }
    } catch (e) {
      catchAnyException(
        AuthenticationError.Exception,
        e.toString(),
      );
      setAuthenticationStatus(AuthenticationStatus.NotLoggedIn);
    }
  }

  @override
  String create2fAToken() {
    String base64str, token = '';
    var rndIndex, rndChar = [];

    try {
      rndChar = calculateRndNumberChar();
      base64str = calculateBase64Encode(rndChar);
      rndIndex = return5RandomIndices(base64str);
      token = returnAuthenticationToken(base64str, rndIndex);
    } catch (e) {
      print(e.toString());
    }

    return token;
  }

  @override
  List calculateRndNumberChar() {
    Random random = new Random();
    var rndChar = [];

    for (int i = 0; i < 15; i++) {
      rndChar.add(random.nextInt(100));
    }
    return rndChar;
  }

  @override
  String calculateBase64Encode(var randomChar) {
    var str = this._studentId + this._lastName + randomChar.toString();
    var bytes = utf8.encode(str);
    var base64str = base64.encode(bytes);

    return base64str;
  }

  @override
  Iterable return5RandomIndices(var base64str) {
    Random random = new Random();
    var rndIndex = [];
    for (int i = 0; i < 5; i++) {
      rndIndex.add(random.nextInt(base64str.length));
    }

    return rndIndex;
  }

  @override
  String returnAuthenticationToken(String base64str, Iterable rndIndex) {
    var token = '';
    for (int i = 0; i < 5; i++) {
      token = token + base64str[rndIndex.elementAt(i)];
    }

    return token;
  }

  Future<void> validate2fAToken(String token) async {
    setAuthenticationStatus(AuthenticationStatus.Authenticating);
    try {
      final http.Response response = await http.get(
        Uri.parse("$api$_studentId/token.json"),
      );

      if (response.statusCode == 200) {
        print("200");
        var _token = jsonDecode(response.body);
        print(token);
        print(_token);
        if (_token == token) {
          _loggedInStatus = AuthenticationStatus.LoggedIn;
          notifyListeners();
          PreferenceService().putString('studentId', _studentId);
          PreferenceService().putString('firstName', _firstName);
          PreferenceService().putString('lastName', _lastName);
        } else {
          catchAnyException(
            AuthenticationError.Exception,
            "The entered token is invalid.",
          );
        }
      }
    } catch (e) {
      if (e is SocketException) {
        catchAnyException(
          AuthenticationError.Exception,
          e.toString(),
        );
        setAuthenticationStatus(AuthenticationStatus.NotLoggedIn);
      } else {
        catchAnyException(
          AuthenticationError.Exception,
          e.toString(),
        );
        setAuthenticationStatus(AuthenticationStatus.NotLoggedIn);
      }
    }
  }

  void setAuthenticationStatus(AuthenticationStatus status) {
    _loggedInStatus = status;
    notifyListeners();
  }

  void catchAnyException(AuthenticationError error, String exception) {
    this.exception = exception;
    _authenticationError = error;
    notifyListeners();
  }

  /// The api uri for the database.
  static const String api =
      'https://mis21-61b88-default-rtdb.europe-west1.firebasedatabase.app/studentprofile/';
}

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../models.dart';

/// Indicates the current authentication status for a user.
///
enum AuthenticationStatus {
  NotLoggedIn,
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
/// The service consists of an [login] and [initAndPatch2fAToken].
///
/// The [login] validates the users input. Throws an [SocketException] in an
/// case of an network error. Throws an [Exception] if the [_studentId] or
/// [_lastName] fails to validate.
///
class AuthenticationProvider extends ChangeNotifier {
  /// A text containing the current exception that occurred.
  ///
  late String exception;

  /// A value containing the unique student id.
  ///
  late String _studentId;

  /// A value containing the last name of a user.
  ///
  late String _lastName;

  /// A random character sequence used in the two factor authentication.
  ///
  late String _token;

  /// The api uri for the database.
  static const String api =
      'https://mis21-61b88-default-rtdb.europe-west1.firebasedatabase.app/studentprofile/';

  /// Sets the value of the student id.
  ///
  set studentId(String? id) => this._studentId = id!;

  /// Sets the value of the user last name.
  ///
  set lastName(String? name) => this._lastName = name!;

  /// Getter and setter for the current error status.
  ///
  AuthenticationError get authenticationError => _authenticationError;
  AuthenticationError _authenticationError = AuthenticationError.NoError;

  /// Getter and setter for the current authentication status of a user.
  ///
  AuthenticationStatus get loggedInStatus => _loggedInStatus;
  AuthenticationStatus _loggedInStatus = AuthenticationStatus.NotLoggedIn;

  Future login(String id, String name) async {
    setAuthenticationStatus(AuthenticationStatus.Authenticating);
    try {
      final http.Response response = await http.get(
        Uri.parse("$api$id.json"),
      );

      if (response.statusCode == 200) {
        Student _student = createStudentModel(response);
        if (validateStudentLastName(_student.lastName!, name)) {
          studentId = _student.studentId;
          lastName = _student.lastName;
          await initAndPatch2fAToken();

          setAuthenticationStatus(AuthenticationStatus.ReadyFor2fA);
        } else {
          catchAnyException(AuthenticationError.Error, "");
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
          AuthenticationError.Error,
          e.toString(),
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

  bool validateStudentLastName(String lastNameFromDb, String inputLastName) {
    return lastNameFromDb == inputLastName ? true : false;
  }

  void initLocalStudentVariables(String studentId, String lastName) {
    this._studentId = studentId;
    this._lastName = lastName;
  }

  Future initAndPatch2fAToken() async {
    this._token = init2fA();
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

  String init2fA() {
    String base64str, token = '';
    var rndIndex, rndChar = [];

    try {
      rndChar = calculateRandomNumberWith15Char();
      base64str = calculateBase64Encode(rndChar);
      rndIndex = pick5RandomIndices(base64str);
      token = pickAuthenticationToken(base64str, rndIndex);
    } catch (e) {
      print(e.toString());
    }

    return token;
  }

  List calculateRandomNumberWith15Char() {
    Random random = new Random();
    var rndChar = [];

    for (int i = 0; i < 15; i++) {
      rndChar.add(random.nextInt(100));
    }
    return rndChar;
  }

  String calculateBase64Encode(var randomChar) {
    var str = this._studentId + this._lastName + randomChar.toString();
    var bytes = utf8.encode(str);
    var base64str = base64.encode(bytes);

    return base64str;
  }

  Iterable pick5RandomIndices(var base64str) {
    Random random = new Random();
    var rndIndex = [];
    for (int i = 0; i < 5; i++) {
      rndIndex.add(random.nextInt(base64str.length));
    }

    return rndIndex;
  }

  String pickAuthenticationToken(String base64str, Iterable rndIndex) {
    var token = '';
    for (int i = 0; i < 5; i++) {
      token = token + base64str[rndIndex.elementAt(i)];
    }

    return token;
  }

  Future validate2fAToken(String token) async {
    setAuthenticationStatus(AuthenticationStatus.Authenticating);
    try {
      final http.Response response = await http.get(
        Uri.parse("$api$_studentId/token.json"),
      );

      if (response.statusCode == 200) {
        var _token = jsonDecode(response.body);
        if (_token == token)
          print('TRUE');
        else
          print('FALSE');
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
          AuthenticationError.Error,
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
}

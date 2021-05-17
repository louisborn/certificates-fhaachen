import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:certificates/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

enum AuthenticationStatus {
  NotLoggedIn,
  Authenticating,
  ReadyFor2fA,
  WaitingFor2fAToken,
}

enum AuthenticationError {
  NoError,
  NetworkError,
  AuthError,
}

/// A provider for the authentication of a user in the application.
///
/// Implements a basic [login] function based on the [studentId] and
/// [_lastName] and a [init2fA] creating a two factor authentication.
///
class AuthenticationProvider extends ChangeNotifier {
  String _studentId, _lastName;

  static const String API =
      'https://mis21-61b88-default-rtdb.europe-west1.firebasedatabase.app/studentprofile/';

  AuthenticationError _errorStatus = AuthenticationError.NoError;
  AuthenticationStatus _loggedInStatus = AuthenticationStatus.NotLoggedIn;

  AuthenticationError get errorStatus => _errorStatus;
  AuthenticationStatus get loggedInStatus => _loggedInStatus;

  /// Authenticates a user with the [studentId] and [lastName].
  Future login(String studentId, String lastName) async {
    _loggedInStatus = AuthenticationStatus.Authenticating;
    notifyListeners();

    try {
      final http.Response response = await http.get(
        Uri.parse("$API$studentId.json"),
      );

      if (response.statusCode == 200) {
        Student _student = createStudentModel(response);
        if (validateStudentLastName(_student.lastName, lastName)) {
          initLocalStudentVariables(_student.studentId, _student.lastName);
          await initAndPatch2fAToken();

          _loggedInStatus = AuthenticationStatus.ReadyFor2fA;
          notifyListeners();
        } else
          catchAuthenticationError();
      } else
        catchNetworkException();
    } on SocketException {
      catchNetworkException();
    } catch (exception) {
      catchAuthenticationError();
    }
  }

  Student createStudentModel(http.Response response) {
    Student _student = Student.fromJson(
      jsonDecode(response.body),
    );
    return _student;
  }

  /// Returns 'true' if the input last name is equal to the last name
  /// in the database.
  bool validateStudentLastName(String lastNameFromDb, String inputLastName) {
    return lastNameFromDb == inputLastName ? true : false;
  }

  void initLocalStudentVariables(String studentId, String lastName) {
    this._studentId = studentId;
    this._lastName = lastName;
  }

  /// Initializes the two factor authentication and patches the
  /// created [_token] to the database.
  Future initAndPatch2fAToken() async {
    var _token = '';

    _token = init2fA();

    try {
      final http.Response response = await http.patch(
        Uri.parse("$API$_studentId.json"),
        body: jsonEncode({"token": _token}),
      );

      if (response.statusCode == 200) {
        _loggedInStatus = AuthenticationStatus.WaitingFor2fAToken;
        notifyListeners();
      } else
        catchAuthenticationError();
    } on SocketException {
      catchNetworkException();
    } catch (exception) {
      catchAuthenticationError();
    }
  }

  /// Returns the 2fA [token] if the two factor authentication
  /// initialization succeeds.
  String init2fA() {
    String base64str, token = '';
    var rndIndex, rndChar = [];

    try {
      rndChar = calculateRandomNumberWith15Char();
      base64str = calculateBase64Encode(rndChar);
      rndIndex = pick5RandomIndices(base64str);
      token = pickAuthenticationToken(base64str, rndIndex);
    } catch (exception) {
      print(exception.toString());
    }

    return token;
  }

  /// Returns a random number of 15 character between 0-100.
  Iterable calculateRandomNumberWith15Char() {
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

  /// Returns 5 indices picked from the [base64str].
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

  /// Validates the entered token by the user.
  Future validate2fAToken(String token) async {
    _loggedInStatus = AuthenticationStatus.Authenticating;
    notifyListeners();

    try {
      final http.Response response = await http.get(
        Uri.parse("$API$_studentId/token.json"),
      );

      if (response.statusCode == 200) {
        var _token = jsonDecode(response.body);
        if (_token == token)
          print('TRUE');
        else
          print('FALSE');
      }
    } on SocketException {
      catchNetworkException();
    } catch (exception) {
      catchAuthenticationError();
    }
  }

  void catchNetworkException() {
    _errorStatus = AuthenticationError.NetworkError;
    notifyListeners();
  }

  void catchAuthenticationError() {
    _errorStatus = AuthenticationError.AuthError;
    notifyListeners();
  }
}

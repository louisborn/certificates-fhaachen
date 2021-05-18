import 'package:flutter/material.dart';

import 'package:certificates/components.dart';
import 'package:certificates/theme.dart';

//* A Callout to display a success information.
//* @params title The title message of the callout.
Container calloutSuccess(String title) {
  return Container(
    width: double.infinity,
    color: SUCCESS.withOpacity(0.1),
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          buildIcon(Icons.check_circle_outline, SUCCESS),
          SizedBox(width: 16.0),
          Flexible(
            child: Container(
              child: Text(
                title,
                style: TextStyle(color: SUCCESS, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

//* A Callout to display a attention information.
//* @params title The title message of the callout.
Container calloutAttention(String title) {
  return Container(
    width: double.infinity,
    color: ATTENTION.withOpacity(0.1),
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          buildIcon(Icons.info_outline, ATTENTION),
          SizedBox(width: 16.0),
          Flexible(
            child: Container(
              child: Text(
                title,
                style: TextStyle(color: ATTENTION, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

//* A Callout to display a error information.
//* @params title The title message of the callout.
Container calloutError(String title) {
  return Container(
    width: double.infinity,
    color: ERROR.withOpacity(0.1),
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          buildIcon(Icons.error_outline, ERROR),
          SizedBox(width: 16.0),
          Flexible(
            child: Container(
              child: Text(
                title,
                style: TextStyle(color: ERROR, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

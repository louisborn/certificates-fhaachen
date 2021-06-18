import 'package:flutter/material.dart';

import '../../../components.dart';
import '../../../models.dart';
import '../../../theme.dart';

/// A table used in this application.
///
/// ignore: must_be_immutable
class BuildTable extends StatefulWidget {
  /// Create a table.
  ///
  /// The [data] and [tableHeader] is required.
  ///
  BuildTable({
    required this.data,
    required this.tableHeader,
  });

  /// The content for the table.
  final List<Log> data;

  /// The table header.
  final List tableHeader;

  /// Is used to check if the table content is sorted
  /// by workspace.
  ///
  bool isSortedByWorkspace = false;

  /// Is used to check if the table content is sorted
  /// by enter time.
  ///
  bool isSortedByEnter = false;

  /// Is used to check if the table content is sorted
  /// by leave time.
  ///
  bool isSortedByLeave = false;

  @override
  _BuildTableState createState() => _BuildTableState();
}

class _BuildTableState extends State<BuildTable> {
  /// Sorts the [BuildTable] content by workspace.
  void sortByWorkspace() {
    setState(() {
      widget.data.sort(
        (a, b) => a.workspaceName!.compareTo(b.workspaceName!),
      );
      widget.isSortedByWorkspace = true;
      widget.isSortedByEnter = false;
      widget.isSortedByLeave = false;
    });
  }

  /// Sorts the [BuildTable] content by the enter time.
  void sortByEnter() {
    setState(() {
      widget.data.sort(
        (a, b) => a.enter!.compareTo(b.enter!),
      );
      widget.isSortedByWorkspace = false;
      widget.isSortedByEnter = true;
      widget.isSortedByLeave = false;
    });
  }

  /// Sorts the [BuildTable] content by the leave time.
  void sortByLeave() {
    setState(() {
      widget.data.sort(
        (a, b) => a.leave!.compareTo(b.leave!),
      );
      widget.isSortedByWorkspace = false;
      widget.isSortedByEnter = false;
      widget.isSortedByLeave = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget tableHeaderRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: sortByWorkspace,
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Text(
              widget.tableHeader[0],
              style: widget.isSortedByWorkspace == true
                  ? BuildTextStyle(type: TextBackground.white)
                      .header3
                      .copyWith(color: color_accent_green)
                  : BuildTextStyle(type: TextBackground.white).header3,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GestureDetector(
          onTap: sortByEnter,
          child: Container(
            width: MediaQuery.of(context).size.width / 4,
            child: Text(
              widget.tableHeader[1],
              style: widget.isSortedByEnter == true
                  ? BuildTextStyle(type: TextBackground.white)
                      .header3
                      .copyWith(color: color_accent_green)
                  : BuildTextStyle(type: TextBackground.white).header3,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GestureDetector(
          onTap: sortByLeave,
          child: Container(
            width: MediaQuery.of(context).size.width / 3.4,
            child: Text(
              widget.tableHeader[2],
              style: widget.isSortedByLeave == true
                  ? BuildTextStyle(type: TextBackground.white)
                      .header3
                      .copyWith(color: color_accent_green)
                  : BuildTextStyle(type: TextBackground.white).header3,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );

    final Widget divider = Container(
      height: 2.0,
      width: double.infinity,
      color: Color(0xff000000),
    );

    final Widget tableContent = Expanded(
      child: ListView.builder(
        itemCount: widget.data.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
              top: 4.0,
              bottom: 4.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(
                        widget.data[index].workspaceName!,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 5,
                      child: Text(
                        widget.data[index].enter!,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 5,
                      child: Text(
                        widget.data[index].leave!,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    BuildIconButton(
                      icon: Icons.more_vert_outlined,
                      onTap: () async {
                        _showInformation(index);
                      },
                      hint: 'Shows more information',
                    ),
                  ],
                ),
                Divider(
                  color: color_gray50,
                ),
              ],
            ),
          );
        },
      ),
    );

    final Widget result = Column(
      children: [
        tableHeaderRow,
        const SizedBox(height: 16.0),
        divider,
        const SizedBox(height: 16.0),
        tableContent,
      ],
    );

    return result;
  }

  /// Shows a dialog with more specific information
  /// on the workspace access of a user.
  ///
  Future<void> _showInformation(int index) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('More information'),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: '),
                        Text('Date: '),
                        Text('Enter time: '),
                        Text('Leave time: '),
                        Text('Student id: '),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.data[index].workspaceName!),
                        Text(widget.data[index].date!),
                        Text(widget.data[index].enter!),
                        Text(widget.data[index].leave!),
                        Text(widget.data[index].studentId!),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

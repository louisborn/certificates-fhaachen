import 'package:flutter/material.dart';

import '../../../models.dart';
import '../../../theme.dart';

// ignore: must_be_immutable
class BuildTable extends StatefulWidget {
  BuildTable({
    required this.data,
    required this.tableHeader,
  });

  final List<Log> data;

  final List tableHeader;

  bool isSortedByWorkspace = false;

  bool isSortedByEnter = false;

  bool isSortedByLeave = false;

  @override
  _BuildTableState createState() => _BuildTableState();
}

class _BuildTableState extends State<BuildTable> {
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
            width: MediaQuery.of(context).size.width / 4,
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
            width: MediaQuery.of(context).size.width / 4,
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
            padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text(
                    widget.data[index].workspaceName!,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text(
                    widget.data[index].enter!,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text(
                    widget.data[index].leave!,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
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
}

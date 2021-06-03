import 'package:certificates/components.dart';
import 'package:certificates/generated/i18n.dart';
import 'package:certificates/models.dart';
import 'package:certificates/screens.dart';
import 'package:certificates/services.dart';
import 'package:certificates/src/theme/colors.dart';
import 'package:flutter/material.dart';

class CampusScreen extends StatefulWidget {
  static const String route = "/campus";

  @override
  _CampusScreenState createState() => _CampusScreenState();
}

class _CampusScreenState extends State<CampusScreen> {
  late Future future;

  @override
  void initState() {
    this.future = Collection<Campus>(path: 'campus').getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = BuildAppBar(
      title: 'Campus status',
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color_accent_green),
        ),
        const SizedBox(width: 8.0),
        Text(I18n.of(context).loading),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: FutureBuilder(
        future: this.future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError)
            return BuildCallout(
              type: CalloutType.error,
              title: I18n.of(context).error_default,
            );

          if (snapshot.hasData && snapshot.data == false)
            return BuildCallout(
              type: CalloutType.attention,
              title: I18n.of(context).error_noData,
            );

          if (snapshot.connectionState == ConnectionState.done) {
            List<Campus> campus = snapshot.data;
            return ListView.builder(
              itemCount: campus.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    CampusDetailScreen.route,
                    arguments: Campus(
                      id: campus[index].id,
                      name: campus[index].name,
                      phone: campus[index].phone,
                      email: campus[index].email,
                      street: campus[index].street,
                      postal: campus[index].postal,
                      city: campus[index].city,
                    ),
                  ),
                  child: ListTile(
                    leading: BuildIcon(
                      icon: Icons.home_work_outlined,
                    ),
                    title: Text(
                      campus[index].name!,
                    ),
                    trailing: BuildIcon(
                      icon: Icons.arrow_forward_ios_outlined,
                    ),
                  ),
                );
              },
            );
          }

          return Center(
            child: loading,
          );
        },
      ),
    );
  }
}

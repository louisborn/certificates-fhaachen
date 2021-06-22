import 'package:flutter/material.dart';

import '../../components.dart';
import '../../generated/i18n.dart';
import '../../models.dart';
import '../../services.dart';
import '../../theme.dart';

/// A screen to provide frequent asked questions.
///
/// Important: The questions can not be translated over i18n because
/// they are fetched from the api.
///
class FAQScreen extends StatefulWidget {
  /// The route name for this screen.
  static const String route = "/home/faq";

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  /// The future for the data collection.
  late Future future;

  @override
  void initState() {
    this.future = Collection<FAQ>(path: 'faq').getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// The app bar for this route.
    final PreferredSizeWidget appBar = BuildAppBar(
      title: I18n.of(context).faqTitle,
    );

    /// The loading animation.
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color_accent_green),
        ),
        const SizedBox(
          width: 8.0,
        ),
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
            List<FAQ> faq = snapshot.data;
            return ListView.builder(
              itemCount: faq.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    top: 24.0,
                    right: 24.0,
                  ),
                  child: _buildQuestions(context, index, faq),
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

  /// The widget to build the questions and anwsers text.
  ///
  Widget _buildQuestions(BuildContext context, int index, List<FAQ> faq) {
    /// The number of the question.
    var number = index + 1;

    /// The text for the question.
    final Widget textForQuestion = Text(
      number.toString() + '. ' + faq[index].question,
      style: BuildTextStyle(type: TextBackground.white).body1,
    );

    /// The text for the answer.
    final Widget textForAnswer = Text(
      faq[index].answer,
      style: BuildTextStyle(type: TextBackground.white).body2,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textForQuestion,
        const SizedBox(
          height: 8.0,
        ),
        textForAnswer,
      ],
    );
  }
}

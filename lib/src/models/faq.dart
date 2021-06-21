class FAQ {
  FAQ({
    required this.question,
    required this.answer,
    this.type,
  });

  final String question;

  final String answer;

  final String? type;

  factory FAQ.fromMap(Map data) {
    return FAQ(
      question: data["question"],
      answer: data["answer"],
      type: data["type"],
    );
  }
}

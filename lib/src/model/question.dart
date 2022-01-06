import 'option.dart';

class Question {
  final String question;
  final Option option1;
  final Option option2;
  final int correctOption;
  bool isQuestionAnswered;

  Question(
      {required this.question,
      required this.option1,
      required this.option2,
      required this.correctOption,
      required this.isQuestionAnswered});
}

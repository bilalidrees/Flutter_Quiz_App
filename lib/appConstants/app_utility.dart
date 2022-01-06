
import 'package:googly/src/model/option.dart';
import 'package:googly/src/model/question.dart';


class AppUtility {
  static String? currentAsset="ufone";

  static List<Question> questionList = [
    Question(
        question: 'Hasn Ali ne pehla T20 match kab khela?',
        option1: Option(option: '2019', type: 1),
        option2: Option(option: '2016', type: 2),
        correctOption: 2,
        isQuestionAnswered: false),
    Question(
        question: 'Hasn Ali kis PSL franchise ke liye khailtay hain?',
        option1: Option(option: 'Peshawar Zalmi', type: 1),
        option2: Option(option: 'Islamabad United', type: 2),
        correctOption: 2,
        isQuestionAnswered: false),
    Question(
        question: 'Muhammad Rizwan ki mojooda PSL team ka naam batayen?',
        option1: Option(option: 'Islamabad United', type: 1),
        option2: Option(option: ' Multan Sultans', type: 2),
        correctOption: 2,
        isQuestionAnswered: false),
    Question(
        question:
            'Muhammad Rizwan ne apni pehli T20 century kis team ke khilaaf ki?',
        option1: Option(option: 'Sri Lanka', type: 1),
        option2: Option(option: 'South Africa', type: 2),
        correctOption: 2,
        isQuestionAnswered: false),
    Question(
        question: 'PSL ka pehla edition kis team ne jeeta?',
        option1: Option(option: 'Quetta Gladiators', type: 1),
        option2: Option(option: 'Islamabad United', type: 2),
        correctOption: 2,
        isQuestionAnswered: false),
    Question(
        question: 'Australia kitne World Cups Jeet chuka hai?',
        option1: Option(option: '5', type: 1),
        option2: Option(option: '4', type: 2),
        correctOption: 1,
        isQuestionAnswered: false),
    Question(
        question: 'Pakistan Team ka Highest ODI Score kia hai?',
        option1: Option(option: '399', type: 1),
        option2: Option(option: '405', type: 2),
        correctOption: 1,
        isQuestionAnswered: false),
    Question(
        question: '1975 aur 1979 ka Cricket World Cup konsa mulk jeeta?',
        option1: Option(option: 'India', type: 1),
        option2: Option(option: 'West Indies', type: 2),
        correctOption: 2,
        isQuestionAnswered: false),
    Question(
        question: 'PSL ka dusra edition kis team ne jeeta?',
        option1: Option(option: 'Peshawar Zalmi', type: 1),
        option2: Option(option: 'Quetta Gladiators', type: 2),
        correctOption: 1,
        isQuestionAnswered: false),
    Question(
        question: 'India Kitne World Cups Jeet chuka hai?',
        option1: Option(option: '3', type: 1),
        option2: Option(option: '2', type: 2),
        correctOption: 2,
        isQuestionAnswered: false),
    Question(
        question: 'Pakistan Team ka Highest T20I Score kia hai?',
        option1: Option(option: '201', type: 1),
        option2: Option(option: '205', type: 2),
        correctOption: 2,
        isQuestionAnswered: false),
    Question(
        question: '1983 ka Cricket World Cup konsa Mulk jeeta?',
        option1: Option(option: 'India', type: 1),
        option2: Option(option: 'Australia', type: 2),
        correctOption: 1,
        isQuestionAnswered: false),
    Question(
        question: 'PSL ka teesra edition kis team ne jeeta?',
        option1: Option(option: 'Peshawar Zalmi', type: 1),
        option2: Option(option: 'Islamabad United', type: 2),
        correctOption: 2,
        isQuestionAnswered: false),
    Question(
        question: 'West Indies Kitne World Cups jeet chuka hai?',
        option1: Option(option: '2', type: 1),
        option2: Option(option: '1', type: 2),
        correctOption: 1,
        isQuestionAnswered: false),
    Question(
        question: 'PSL ka last edition konsi team ne jeeta?',
        option1: Option(option: 'Karachi Kings', type: 1),
        option2: Option(option: 'Islamabad United', type: 2),
        correctOption: 1,
        isQuestionAnswered: false),
  ];
}

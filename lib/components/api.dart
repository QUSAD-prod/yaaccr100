import 'package:yaaccr100/components/test_question.dart';
import 'package:collection/collection.dart';

class MyApi {
  List<Map<dynamic, dynamic>> getQuestionList() {
    List<Map<dynamic, dynamic>> temp = TestQuestion().getList();
    return temp.sample(30);
  }
}

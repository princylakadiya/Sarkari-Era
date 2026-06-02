import 'dart:convert';
import 'package:http/http.dart' as http;

class CallExamDetailsApi{

  static Future<Map> getExamDetails({required String tableName, required String examName}) async {

    Map map={
      'table_name': tableName,
      'exam_name': examName
    };

    var url = Uri.parse('http://10.0.2.2/php_projects/sarkari_era_apis/getExamDetails.php');
    var response = await http.post(url, body: jsonEncode(map));
    Map map1=jsonDecode(response.body);
    return map1;
  }

}
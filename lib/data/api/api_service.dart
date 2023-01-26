import 'package:breakingbad_app/constants/strings.dart';
import 'package:dio/dio.dart';

class ApiServices {
  late Dio dio1;
  ApiServices() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 20 * 1000,
        receiveTimeout: 20 * 1000,
        receiveDataWhenStatusError: true);
    dio1 = Dio(baseOptions);
  }
  Future<List<dynamic>> getAllCharacters() async {
    try {
      var response = await dio1.get('characters');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
   Future<List<dynamic>> getQuotes(String charName)async{
  try{
    var response = await dio1.get('quote',queryParameters: {'author':charName});
    print(response.data);
    return response.data;
  }catch(e){
    print(e.toString());
    return [];
  }
   }
}

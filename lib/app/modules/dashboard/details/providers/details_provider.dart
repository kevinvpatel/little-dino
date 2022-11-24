import 'dart:convert';

import 'package:http/http.dart' as http;
import '../details_model.dart';

class DetailsProvider {

  Future<Details?> getDetails({required String id}) async {
     Details? details;
    try {
      http.Response response = await http.get(
          Uri.parse('http://tubfl.com/littledino/public/api/v1/products?category_id=$id'),
          headers: {'auth-key' : 'simplerestapi'}
      );
      if(response.statusCode == 200){
        details = Details.fromJson(json.decode(response.body));
      }
    } catch(err) {
      print('get Detail api err -> $err');
    }
    return details;
  }

}

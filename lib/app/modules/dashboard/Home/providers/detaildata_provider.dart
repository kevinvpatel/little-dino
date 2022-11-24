import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/sockets_html.dart';
import 'package:little_dino_app/app/modules/dashboard/Home/allDetailDatas.dart';

import '../category_model.dart';

class AllDetailsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Category.fromJson(map);
      if (map is List)
        return map.map((item) => Category.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'http://tubfl.com/littledino/public/api/v1/all/products';
  }

  Future<AllDetails?> alldetailsofcategories() async {
    AllDetails? allDetails;
    final response = await get(
        'http://tubfl.com/littledino/public/api/v1/all/products',
        headers: {
          'auth-key':'simplerestapi'
        }
    );
    allDetails = AllDetails.fromJson(response.body);
    return allDetails;
  }

  Future postCategory(Category category) async =>
      await post('category', category);
  Future<Response> deleteCategory(int id) async => await delete('category/$id');
}

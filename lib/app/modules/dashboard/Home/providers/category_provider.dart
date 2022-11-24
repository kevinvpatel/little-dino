import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/sockets_html.dart';

import '../category_model.dart';

class CategoryProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Category.fromJson(map);
      if (map is List)
        return map.map((item) => Category.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'http://tubfl.com/littledino/public/api/v1/categories?segment=0';
  }

  Future<Category?> getCategory() async {
    Category? category;
    final response = await get(
        'http://tubfl.com/littledino/public/api/v1/categories',
        headers: {
          'auth-key':'simplerestapi'
        }
    );
    category = Category.fromJson(response.body);
    return category;
  }

  Future postCategory(Category category) async =>
      await post('category', category);
  Future<Response> deleteCategory(int id) async => await delete('category/$id');
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shamo/models/product_model.dart';

class ProductServices{
  String baseUrl = "https://shamo-backend.buildwithangga.id/api";

  Future<List<ProductModel>> getProducts () async{
    var url = Uri.parse('$baseUrl/products');
    var header = {"Content-Type": "application/json"};

    var response = await http.get(url, headers: header);

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }
      return products;
    }else{
      throw Exception('Gagal Memuat Data');
    }
    
  }
}
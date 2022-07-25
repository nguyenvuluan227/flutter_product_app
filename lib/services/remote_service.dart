import 'dart:convert';

import 'package:flutter_product_app/models/response/product_response.dart';
import 'package:flutter_product_app/models/response/register_response.dart';
import 'package:flutter_product_app/services/api_service.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<ProductResponse>?> getProducts() async {
    var client = http.Client();
    var uri = Uri.parse(ApiService.BASE_URL + ApiService.GET_PRODUCTS);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return productFromJson(json);
    }
  }

  Future<RegisterReponse?> doRegister(String email, String password) async {
    var client = http.Client();
    var uri = Uri.parse(ApiService.BASE_URL + ApiService.REGISTER);
    Map<String, String> headers = {
      'Content-type': 'application/json; charset=UTF-8'
    };
    var response = await client.post(uri,
        headers: headers,
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }));
    if (response.statusCode == 200) {
      var json = response.body;
      return registerFromJson(json);
    }
  }
}

import 'dart:convert';
import 'package:flutter_product_app/models/response/login_response.dart';
import 'package:flutter_product_app/models/response/product_response.dart';
import 'package:flutter_product_app/models/response/register_response.dart';
import 'package:flutter_product_app/services/api_service.dart';
import 'package:http/http.dart' as http;

class RemoteService {

  Future<List<ProductResponse>?> getProducts(String? token) async {
    var client = http.Client();
    var uri = Uri.parse(ApiService.BASE_URL + ApiService.GET_PRODUCTS);
    Map<String, String> headers = {'Authorization': 'Bearer${token ?? ""}'};
    var response = await client.get(uri, headers: headers);
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

  Future<LoginResponse?> doLogin(String email, String password) async {
    var client = http.Client();
    var uri = Uri.parse(ApiService.BASE_URL + ApiService.LOGIN);
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
      return loginFromJson(json);
    }
  }
}

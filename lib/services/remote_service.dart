import 'package:flutter_product_app/models/product.dart';
import 'package:flutter_product_app/services/api_service.dart';
import 'package:http/http.dart' as http;

class RemoteService {

  Future<List<Product>?> getProducts() async {
    var client = http.Client();
    var uri = Uri.parse(ApiService.GET_PRODUCTS);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return productFromJson(json);
    }
  }

}

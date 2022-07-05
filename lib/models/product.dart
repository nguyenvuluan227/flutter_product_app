
import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  int id;
  String sku;
  String productName;
  int qty;
  int price;
  String unit;
  dynamic image;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  Product({
    required this.id,
    required this.sku,
    required this.productName,
    required this.qty,
    required this.price,
    required this.unit,
    this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        sku: json["sku"],
        productName: json["product_name"],
        qty: json["qty"],
        price: json["price"],
        unit: json["unit"],
        image: json["image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "product_name": productName,
        "qty": qty,
        "price": price,
        "unit": unit,
        "image": image,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

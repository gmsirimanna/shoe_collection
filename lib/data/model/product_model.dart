import 'package:flutter/cupertino.dart';

class ProductModel {
  String result;
  List<Product> data;

  ProductModel({this.result, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String id;
  String sKU;
  String name;
  String brandName;
  String mainImage;
  Price price;
  List<String> sizes;
  String stockStatus;
  String colour;
  String description;

  Product({this.id, this.sKU, this.name, this.brandName, this.mainImage, this.price, this.sizes, this.stockStatus, this.colour, this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sKU = json['SKU'];
    name = json['name'];
    brandName = json['brandName'];
    mainImage = json['mainImage'];
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    sizes = json['sizes'].cast<String>();
    stockStatus = json['stockStatus'];
    colour = json['colour'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['SKU'] = this.sKU;
    data['name'] = this.name;
    data['brandName'] = this.brandName;
    data['mainImage'] = this.mainImage;
    if (this.price != null) {
      data['price'] = this.price.toJson();
    }
    data['sizes'] = this.sizes;
    data['stockStatus'] = this.stockStatus;
    data['colour'] = this.colour;
    data['description'] = this.description;
    return data;
  }
}

class Price {
  String amount;
  String currency;

  Price({this.amount, this.currency});

  Price.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    return data;
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:products_list/data/model/product_model.dart';
import 'package:products_list/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({@required this.sharedPreferences});

  List<Product> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST);
    }
    List<Product> cartList = [];
    carts.forEach((cart) => cartList.add(Product.fromJson(jsonDecode(cart))));
    return cartList;
  }

  void addToCartList(List<Product> cartProductList) {
    List<String> carts = [];
    cartProductList.forEach((cartModel) => carts.add(jsonEncode(cartModel)));
    sharedPreferences.setStringList(AppConstants.CART_LIST, carts);
  }
}

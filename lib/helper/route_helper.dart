import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:products_list/data/model/product_model.dart';
import 'package:products_list/screens/cart_screen.dart';
import 'package:products_list/screens/home_screen.dart';
import 'package:products_list/screens/product_screen.dart';
import 'package:products_list/screens/splash_screen.dart';

class RouteHelper {
  static final FluroRouter router = FluroRouter();

  static String splash = '/Splash';
  static String menu = '/Home';
  static String cart = '/Cart';
  static String product = '/Product';

  static String getMainRoute() => menu;
  static final Handler _menuHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => HomeScreen());
  static final Handler _splashHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => SplashScreen());
  static Handler _cartHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => CartScreen());
  static Handler _productHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    Product _productDetails = ModalRoute.of(context).settings.arguments;
    return ProductScreen(
      product: _productDetails,
    );
  });

  static void setupRouter() {
    router.define(splash, handler: _splashHandler, transitionType: TransitionType.fadeIn);
    router.define(menu, handler: _menuHandler, transitionType: TransitionType.fadeIn);
    router.define(cart, handler: _cartHandler, transitionType: TransitionType.fadeIn);
    router.define(product, handler: _productHandler, transitionType: TransitionType.fadeIn);
  }
}

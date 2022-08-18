import 'package:flutter/material.dart';
import 'package:products_list/data/model/product_model.dart';
import 'package:products_list/data/repository/cart_repo.dart';
import 'package:products_list/widgets/custom_snackbar.dart';

class CartProvider extends ChangeNotifier {
  final CartRepo cartRepo;
  CartProvider({@required this.cartRepo});

  List<Product> _cartList = [];
  double _total = 0;

  List<Product> get cartList => _cartList;
  double get total => _total;

  void addToCart(Product product, BuildContext context) {
    if (_cartList.indexOf(product) == -1) {
      _cartList.add(product);
      cartRepo.addToCartList(_cartList);
      _total = calculateTotal();
      showCustomSnackBar("Added to cart", context, isError: false);
    } else {
      showCustomSnackBar("Already in cart", context);
    }

    notifyListeners();
  }

  void removeFromCart(int index, BuildContext context) {
    showCustomSnackBar("Removed from cart", context);
    _cartList.removeAt(index);
    _total = calculateTotal();
    cartRepo.addToCartList(_cartList);
    notifyListeners();
  }

  int isExistInCart(Product product) {
    for (int index = 0; index < _cartList.length; index++) {
      if (_cartList[index].id == product.id) {
        return index;
      }
    }
    return -1;
  }

  double calculateTotal() {
    double amount = 0;
    for (Product product in _cartList) {
      amount += double.parse(product.price.amount);
    }
    return amount;
  }
}

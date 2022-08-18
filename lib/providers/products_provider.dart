import 'package:flutter/foundation.dart';
import 'package:products_list/data/repository/products_repo.dart';
import '../data/model/product_model.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/error_response.dart';

class ProductsProvider with ChangeNotifier {
  final ProductsRepo productsRepo;
  ProductsProvider({this.productsRepo});

  bool _isLoading = false;
  bool _isGridSelected = true;
  String _errorMessage = "";

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  List<Product> productList = [];

  List<Product> get cartList => productList;
  bool get isGridSelected => _isGridSelected;

  Future<List<Product>> getAllProducts() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    ApiResponse apiResponse = await productsRepo.getAllProducts();
    ProductModel productModel;
    if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
      productModel = ProductModel.fromJson(apiResponse.response.data);
      productList = productModel.data;
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        errorMessage = errorResponse.errors[0].message;
      }
      print(errorMessage);
      _errorMessage = errorMessage;
      productModel = ProductModel();
    }
    _isLoading = false;
    notifyListeners();
    return productList;
  }

  void setIsGridSelected(value) {
    _isGridSelected = value;
    notifyListeners();
  }
}

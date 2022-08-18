import 'package:flutter/material.dart';
import 'package:products_list/data/model/product_model.dart';
import 'package:products_list/screens/widget/product_detail_widget.dart';
import 'package:products_list/widgets/custom_app_bar.dart';

class ProductScreen extends StatelessWidget {
  Product product;
  ProductScreen({@required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "PRODUCT DETAILS",
          isBackButtonExist: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ProductDetailWidget(product: product),
          ),
        ));
  }
}

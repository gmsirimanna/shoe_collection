import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:products_list/data/model/product_model.dart';
import 'package:products_list/providers/cart_provider.dart';
import 'package:products_list/screens/widget/cart_product_widget.dart';
import 'package:products_list/util/dimensions.dart';
import 'package:products_list/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "CART SCREEN",
        isBackButtonExist: true,
      ),
      body: Consumer<CartProvider>(builder: (context, cartProvider, child) {
        return cartProvider.cartList.length > 0
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (BuildContext, index) {
                        Product _productDetails = cartProvider.cartList[index];
                        return CartProductWidget(productDetails: _productDetails, index: index);
                      },
                      itemCount: cartProvider.cartList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(5),
                      scrollDirection: Axis.vertical,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    color: Colors.grey.withOpacity(0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "TOTAL AMOUNT : ",
                          style: GoogleFonts.abel(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text('${cartProvider.total.toString()} ${cartProvider.cartList[0].price.currency}',
                            style: GoogleFonts.abel(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  )
                ],
              )
            : Center(
                child: Text(
                  "NO ITEMS IN THE CART",
                  style: GoogleFonts.oswald(fontSize: 17, fontWeight: FontWeight.w300),
                ),
              );
      }),
    );
  }
}

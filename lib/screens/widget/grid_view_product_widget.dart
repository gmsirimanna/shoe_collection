import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:products_list/data/model/product_model.dart';
import 'package:products_list/providers/cart_provider.dart';
import 'package:products_list/util/dimensions.dart';
import 'package:products_list/util/images.dart';
import 'package:provider/provider.dart';

class GridViewProductListWidget extends StatelessWidget {
  const GridViewProductListWidget({
    Key key,
    @required Product productDetails,
  })  : _productDetails = productDetails,
        super(key: key);

  final Product _productDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          vertical: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 80,
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder,
                  image: _productDetails.mainImage,
                  width: 100,
                  placeholderFit: BoxFit.fitWidth,
                  fit: BoxFit.fitWidth,
                  imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, width: 140),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '${_productDetails.name} \n(${_productDetails.brandName})',
              textAlign: TextAlign.start,
              maxLines: 3,
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _productDetails.stockStatus,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.openSans(color: _productDetails.stockStatus.contains("IN") ? Colors.green : Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${_productDetails.price.amount} ${_productDetails.price.currency}',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                    child: Text(
                      _productDetails.stockStatus.contains("IN") ? "ADD TO CART" : "OUT OF STOCK",
                      style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: _productDetails.stockStatus.contains("IN")
                          ? MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 185, 9))
                          : MaterialStateProperty.all<Color>(Color.fromARGB(255, 184, 184, 183)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ))),
                  onPressed: () {
                    if (_productDetails.stockStatus.contains("IN")) {
                      Provider.of<CartProvider>(context, listen: false).addToCart(_productDetails, context);
                    } else {
                      null;
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}

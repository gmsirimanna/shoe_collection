import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:products_list/data/model/product_model.dart';
import 'package:products_list/providers/cart_provider.dart';
import 'package:products_list/util/dimensions.dart';
import 'package:products_list/util/images.dart';
import 'package:provider/provider.dart';

class ProductDetailWidget extends StatelessWidget {
  const ProductDetailWidget({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Center(
                          child: FadeInImage.assetNetwork(
                            placeholder: Images.placeholder,
                            width: double.infinity,
                            image: product.mainImage,
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
                        '${product.name} \n(${product.brandName})',
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        style: GoogleFonts.roboto(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'SKU: ${product.sKU}',
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        style: GoogleFonts.roboto(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Color : ${product.colour}',
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Sizes : ${product.sizes}',
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.stockStatus,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.openSans(color: product.stockStatus.contains("IN") ? Colors.green : Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${product.price.amount} ${product.price.currency}',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Product Description : ",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  product.description,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  child: Text(product.stockStatus.contains("IN") ? "ADD TO CART" : "OUT OF STOCK", style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: product.stockStatus.contains("IN")
                        ? MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 185, 9))
                        : MaterialStateProperty.all<Color>(Color.fromARGB(255, 184, 184, 183)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ))),
                onPressed: () {
                  if (product.stockStatus.contains("IN")) {
                    Provider.of<CartProvider>(context, listen: false).addToCart(product, context);
                  } else {
                    null;
                  }
                }),
          ),
        ),
        SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}

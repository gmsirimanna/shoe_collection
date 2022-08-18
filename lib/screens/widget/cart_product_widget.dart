import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:products_list/data/model/product_model.dart';
import 'package:products_list/helper/route_helper.dart';
import 'package:products_list/providers/cart_provider.dart';
import 'package:products_list/util/dimensions.dart';
import 'package:products_list/util/images.dart';
import 'package:provider/provider.dart';

class CartProductWidget extends StatelessWidget {
  const CartProductWidget({
    Key key,
    @required Product productDetails,
    @required int index,
  })  : _productDetails = productDetails,
        _index = index,
        super(key: key);

  final Product _productDetails;
  final int _index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(RouteHelper.product, arguments: _productDetails),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_DEFAULT),
        margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
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
        child: ListTile(
          leading: Container(
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
          title: Text(
            '${_productDetails.name} \n(${_productDetails.brandName})',
            textAlign: TextAlign.start,
            maxLines: 3,
            style: GoogleFonts.roboto(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
          ),
          subtitle: Text(
            '${_productDetails.price.amount} ${_productDetails.price.currency}',
            textAlign: TextAlign.start,
            style: GoogleFonts.roboto(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
          ),
          trailing: SizedBox(
            width: 50,
            height: 50,
            child: IconButton(
                onPressed: () {
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("Are you sure !"),
                      content: Text("Do you want to remove this item?"),
                      actions: <Widget>[
                        ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                            child: Text("CANCEL", style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold)),
                          ),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 185, 9)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ))),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 29, 9)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ))),
                          onPressed: () {
                            Provider.of<CartProvider>(context, listen: false).removeFromCart(_index, context);
                            Navigator.of(ctx).pop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                            child: Text("DELETE", style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      )
                    ],
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        Images.delete,
                        color: Colors.red,
                      )),
                )),
          ),
        ),
      ),
    );
  }
}

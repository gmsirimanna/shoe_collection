import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:products_list/data/model/product_model.dart';
import 'package:products_list/helper/route_helper.dart';
import 'package:products_list/providers/products_provider.dart';
import 'package:products_list/screens/widget/grid_view_product_widget.dart';
import 'package:products_list/screens/widget/list_view_product_widget.dart';
import 'package:products_list/util/color_resources.dart';
import 'package:products_list/util/images.dart';
import 'package:products_list/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../util/dimensions.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double height, width;
  final textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //call methods after the buld
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<ProductsProvider>(context, listen: false).getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(title: "SHOE COLLECTION"),
      body: Consumer<ProductsProvider>(builder: (context, productProvider, child) {
        return Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          child: productProvider.productList.length > 0
              ? Column(
                  children: [
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        vertical: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        vertical: 5.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Change Layout : ",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.openSans(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                          Spacer(),
                          InkWell(
                              onTap: () {
                                if (!productProvider.isGridSelected) productProvider.setIsGridSelected(true);
                              },
                              child: SvgPicture.asset(
                                Images.as_grid,
                                color: !productProvider.isGridSelected ? ColorResources.COLOR_GREY.withAlpha(70) : Colors.black,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {
                                if (productProvider.isGridSelected) productProvider.setIsGridSelected(false);
                              },
                              child: SvgPicture.asset(
                                Images.as_list,
                                color: productProvider.isGridSelected ? ColorResources.COLOR_GREY.withAlpha(70) : Colors.black,
                              )),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                        child: productProvider.isGridSelected
                            ? GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.7,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                                  vertical: Dimensions.PADDING_SIZE_SMALL,
                                ),
                                physics: BouncingScrollPhysics(),
                                itemCount: productProvider.productList.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  ;
                                  Product _productDetails = productProvider.productList[index];
                                  return InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(RouteHelper.product, arguments: _productDetails);
                                      },
                                      child: GridViewProductListWidget(productDetails: _productDetails));
                                },
                              )
                            : ListView.builder(
                                itemBuilder: (BuildContext, index) {
                                  Product _productDetails = productProvider.cartList[index];
                                  return ListViewProductWidget(productDetails: _productDetails, index: index);
                                },
                                itemCount: productProvider.productList.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.all(5),
                                scrollDirection: Axis.vertical,
                              ))
                  ],
                )
              : Center(
                  child: productProvider.isLoading
                      ? Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL), child: CircularProgressIndicator())
                      : productProvider.errorMessage.isEmpty
                          ? Center(
                              child: Text("NO ITEMS AVAILABLE"),
                            )
                          : Text("SOMETHING WENT WRONG!"),
                ),
        );
      }),
    );
  }
}

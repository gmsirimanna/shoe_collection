import 'package:flutter/material.dart';
import 'package:products_list/helper/route_helper.dart';
import 'package:products_list/providers/cart_provider.dart';
import 'package:products_list/util/images.dart';
import 'package:provider/provider.dart';
import '../util/color_resources.dart';
import '../util/dimensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonExist;
  CustomAppBar({@required this.title, this.isBackButtonExist = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          title,
          style: TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          !isBackButtonExist
              ? IconButton(
                  icon: Stack(clipBehavior: Clip.none, children: [
                    SvgPicture.asset(Images.cart),
                    Positioned(
                      top: -4,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                        child: Text('${Provider.of<CartProvider>(context).cartList.length}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            )),
                      ),
                    ),
                  ]),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteHelper.cart);
                  })
              : SizedBox(),
        ],
        leading: Builder(builder: (BuildContext context) {
          return isBackButtonExist
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                )
              : SizedBox();
        }));
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 60);
}

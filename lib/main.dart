import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'helper/route_helper.dart';
import 'providers/products_provider.dart';
import 'providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'di_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  runApp(
    //Register Providers
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => di.sl<ProductsProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CartProvider>()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    RouteHelper.setupRouter();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, d) {
        return MaterialApp(
          theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFFFFFF)),
          debugShowCheckedModeBanner: false,
          title: 'News App',
          initialRoute: RouteHelper.splash,
          onGenerateRoute: RouteHelper.router.generator,
          navigatorKey: MyApp.navigatorKey,
        );
      },
    );
  }
}

import 'dart:developer';

import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/controller/profile_controller.dart';
import 'package:emart_app/view/home_Screen/cart/component/cart_controller.dart';
import 'package:emart_app/view/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'consts/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              iconTheme: IconThemeData(color: darkFontGrey)),
          fontFamily: regular),
      home: const SplashScreen(),
    );
  }

  // HomeController controller = Get.put(HomeController());
  AuthController authController = Get.put(AuthController());
  ProductController productController = Get.put(ProductController());
  ProfileController profileController = Get.put(ProfileController());
  CartController cartController = Get.put(CartController());
}

import 'package:emart_app/Widget_common/common_appLogo.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/view/auth_screen/login_screen.dart';
import 'package:emart_app/view/home_Screen/bottom_nav_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  chageScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      // Get.to(() => const LoginScreen());
      auth.authStateChanges().listen((User? user) {
        //when
        if (user == null && mounted) {
          Get.offAll(() => const LoginScreen());
        } else {
          Get.offAll(() => BottomNavScreen());
        }
      });
    });
  }

  @override
  void initState() {
    chageScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                icSplashBg,
                width: 300,
              ),
            ),
            20.heightBox,
            Container(
              height: 200,
              width: 200,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  appLogoWidget(),
                  Column(
                    children: [
                      Text(
                        appname,
                        style: GoogleFonts.lobster(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            decorationThickness: 35),
                      ),
                      Text(
                        tagLine,
                        style: GoogleFonts.dancingScript(
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            decorationThickness: 35),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            appversion.text.size(5).make(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                devloper.text.size(4).make(),
                credits.text.fontFamily(semibold).make(),
              ],
            ),
            30.heightBox
          ],
        ),
      ),
    );
  }
}

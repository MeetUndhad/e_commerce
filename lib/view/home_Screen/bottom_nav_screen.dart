import 'package:emart_app/Widget_common/exit_dialog.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/home_controlller.dart';
import 'package:emart_app/view/home_Screen/profile/account.dart';
import 'package:emart_app/view/home_Screen/cart/cart.dart';
import 'package:emart_app/view/home_Screen/category/category.dart';
import 'package:emart_app/view/home_Screen/home_screen/home_screen.dart';
import 'package:get/get.dart';

class BottomNavScreen extends StatelessWidget {
  BottomNavScreen({Key? key}) : super(key: key);
  // final controller = Get.find<HomeController>();
  HomeController controller = Get.put(HomeController());
  var navBody = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  var navBarItem = [
    BottomNavigationBarItem(
        icon: Image.asset(
          icHome,
          width: 26,
        ),
        label: home),
    BottomNavigationBarItem(
        icon: Image.asset(
          icCategories,
          width: 26,
        ),
        label: category),
    BottomNavigationBarItem(
        icon: Image.asset(
          icCart,
          width: 26,
        ),
        label: cart),
    BottomNavigationBarItem(
        icon: Image.asset(
          icProfile,
          width: 26,
        ),
        label: account)
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Obx(() => navBody.elementAt(controller.currentNavIndex.value)),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            items: navBarItem,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}

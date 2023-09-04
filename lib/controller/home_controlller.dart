import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    if (currentUser != null) {
      getUserName();
    }
    super.onInit();
  }

  var currentNavIndex = 0.obs;
  var userName = '';
  var searchController = TextEditingController();
  getUserName() async {
    var n = await firestore
        .collection(userController)
        .where('id', isEqualTo: auth.currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    userName = n;
  }
}

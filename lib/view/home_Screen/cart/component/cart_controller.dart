import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/controller/home_controlller.dart';
import 'package:get/get.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get_storage/get_storage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartController extends GetxController {
  final data = GetStorage();
  Razorpay _razorpay = Razorpay();

  bool paymentDone = false;
  var totalP = 0.obs;

  //controller for shippingdetail
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postelcodeController = TextEditingController();
  var phoneController = TextEditingController();

  late dynamic productSnapshot;

  var products = [];
  var vendors = [];

  var placingOrder = false.obs;

  var paymentIndex = 0.obs;

  // @override
  // void onInit() {
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  //   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  //   _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  //
  //   super.onInit();
  // }

  // bool isProductsExits(int productId) {
  //   bool result = false;
  //
  //   for (var product in myCartList) {
  //     if (product.id == productId) {
  //       result = true;
  //       break;
  //     } else {
  //       result = false;
  //     }
  //   }
  //
  //   print(result);
  //   return result;
  // }

  // void buyNowOnPressed({required price}) {
  //   _razorpay.open({
  //     'key': 'rzp_test_c4eNzNCmn36EQu',
  //     'amount': price * 100,
  //     'name': 'Acme Corp.',
  //     'description': 'Fine T-Shirt',
  //     'prefill': {'contact': '8888888888', 'email': 'mailto:test@razorpay.com'}
  //   });
  // }
  //
  // void _handlePaymentSuccess(PaymentSuccessResponse response) {
  //   paymentDone = true;
  //   update();
  //   // Do something when payment succeeds
  //   print("paymentId: ${response.paymentId}");
  // }
  //
  // void _handlePaymentError(PaymentFailureResponse response) {
  //   // Do something when payment fails
  //   print("payment fails: ${response.error}");
  // }
  //
  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   print("walletName: ${response.walletName}");
  // }

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  chnagePaymentIndex(index) {
    paymentIndex.value = index;
  }

  addPalceOrder({required orderPaymentMethod, required totalAmount}) async {
    placingOrder(true);
    await getProductDetails();
    await firestore.collection(orderCollection).doc().set({
      'order_by': currentUser!.uid,
      'order_date': FieldValue.serverTimestamp(),
      'order_code': "233981237",
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_phone': phoneController.text,
      'order_by_postelcode': postelcodeController.text,
      'shipping_method': "Home Delivery",
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products),
      'vendors': FieldValue.arrayUnion(vendors),
    });
    placingOrder(false);
  }

  getProductDetails() {
    products.clear();
    vendors.clear();
    for (int i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
        'vendor_id': productSnapshot[i]['vendor_id'],
        'tprice': productSnapshot[i]['tprice'],
        'sellerName': productSnapshot[i]['sellerName'],
      });
      vendors.add(productSnapshot[i]['vendor_id']);
    }
  }

  clearCart() {
    for (int i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
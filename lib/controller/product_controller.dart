import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/model/category_model.dart';
import 'package:emart_app/firebase/services/firestore_services.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var quentity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var subCat = [];

  var isFav = false.obs;
  getSubCategory(title) async {
    subCat.clear();
    var data = await rootBundle
        .loadString("lib/firebase/services/category_model.json");
    var decode = categoryModelFromJson(data);
    var filter =
        decode.categories.where((element) => element.name == title).toList();

    for (var e in filter[0].subcategory) {
      subCat.add(e);
    }
  }

  chageColorIndex(index) {
    colorIndex = index;
  }

  quentityIncrease({totalQuentity}) {
    if (quentity.value < totalQuentity) {
      quentity.value++;
    }
  }

  quentityDecrease() {
    if (quentity.value > 0) {
      quentity.value--;
    }
  }

  totalMoney(price) {
    totalPrice.value = price * quentity.value;
  }

  addToCart(
      {title, img, sellerName, color, qty, tprice, context, vendorId}) async {
    await firestore.collection(cartCollection).doc().set({
      "title": title,
      "img": img,
      "sellerName": sellerName,
      "color": color,
      "qty": qty,
      "vendor_id": vendorId,
      "tprice": tprice,
      "added_by": currentUser!.uid
    }).catchError((e) {
      VxToast.show(context, msg: e.toString());
    });
  }

  resetValue() {
    totalPrice.value = 0;
    quentity.value = 0;
    colorIndex.value = 0;
  }

  addToWishList(docId, context) async {
    await firestore.collection(productCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));

    isFav(true);
    VxToast.show(context, msg: "Add to WishList");
  }

  removeFromWishList(docId, context) async {
    await firestore.collection(productCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));

    isFav(false);
    VxToast.show(context, msg: "Remove from WishList");
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}

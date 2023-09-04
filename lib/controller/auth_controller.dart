import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var passController = TextEditingController();
  var emailController = TextEditingController();
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: 'Email or Password is wrong😒');
    }
    return userCredential;
  }

  Future signupMethod({String? email, String? password, context}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  storeUserData({name, password, email}) async {
    DocumentReference store =
        firestore.collection(userController).doc(auth.currentUser!.uid);
    store.set({
      "name": name,
      "password": password,
      "email": email,
      "imageUrl": "",
      "id": currentUser!.uid,
      "cart_count": 00,
      "order_count": 00,
      "wishlist_count": 00,
    });
  }

  signoutMethod(BuildContext context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Widget_common/bg_widget.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/controller/profile_controller.dart';
import 'package:emart_app/firebase/services/firestore_services.dart';
import 'package:emart_app/view/auth_screen/login_screen.dart';
import 'package:emart_app/view/chat_screen/messaging_screen.dart';
import 'package:emart_app/view/home_Screen/profile/component/details_cart.dart';
import 'package:emart_app/view/home_Screen/profile/edit_profle_screen.dart';
import 'package:emart_app/view/orders_screen/order_screen.dart';
import 'package:emart_app/view/wishlist_screen/wishlist_screen.dart';
import 'package:get/get.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: StreamBuilder<QuerySnapshot>(
              stream: FireStoreServices.getUser(currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ));
                } else {
                  var data = snapshot.data!.docs[0];
                  log("======>$data");
                  return SafeArea(
                    child: Column(
                      children: [
                        //edit profile const e
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: const Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.edit,
                                color: whiteColor,
                              )).onTap(() {
                            controller.nameController.text = data['name'];

                            Get.to(() => EditScreen(data: data));
                          }),
                        ),
                        //user detail section
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              data['imageUrl'] == ''
                                  ? Image.asset(
                                      imgProfile2,
                                      fit: BoxFit.fill,
                                      width: 115,
                                    )
                                      .box
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make()
                                  : Image.network(
                                      data['imageUrl'],
                                      fit: BoxFit.fill,
                                      width: 115,
                                    )
                                      .box
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make(),
                              5.widthBox,
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data['name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .white
                                      .make(),
                                  "${data['email']}".text.size(12).white.make(),
                                ],
                              )),
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      side:
                                          const BorderSide(color: whiteColor)),
                                  onPressed: () async {
                                    await Get.put(AuthController())
                                        .signoutMethod(context);
                                    Get.to(() => const LoginScreen());
                                  },
                                  child: "Log out"
                                      .text
                                      .fontFamily(semibold)
                                      .white
                                      .make())
                            ],
                          ),
                        ),
                        25.heightBox,
                        FutureBuilder(
                          future: FireStoreServices.getCounts(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              var countdata = snapshot.data;
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  detailsCart(
                                      width: context.screenWidth / 3.4,
                                      title: "In your cart",
                                      number: countdata[0]),
                                  detailsCart(
                                      width: context.screenWidth / 3.4,
                                      title: "In your wishlist",
                                      number: countdata[1]),
                                  detailsCart(
                                      width: context.screenWidth / 3.4,
                                      title: "Your Order",
                                      number: countdata[2]),
                                ],
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(redColor)),
                              );
                            }
                          },
                        ),

                        // Button section
                        ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      switch (index) {
                                        case 0:
                                          Get.to(() => const OrderScreen());
                                          break;

                                        case 1:
                                          Get.to(() => const WishlistScreen());
                                          break;

                                        case 2:
                                          Get.to(() => const MessageScreen());
                                          break;
                                      }
                                    },
                                    leading: Image.asset(
                                      profileButtonsIcon[index],
                                      width: 22,
                                    ),
                                    title: profileButtonsList[index]
                                        .text
                                        .color(darkFontGrey)
                                        .fontFamily(semibold)
                                        .make(),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemCount: profileButtonsList.length)
                            .box
                            .rounded
                            .margin(const EdgeInsets.all(12))
                            .white
                            .padding(const EdgeInsets.symmetric(horizontal: 16))
                            .shadowSm
                            .make()
                            .box
                            .make()
                      ],
                    ),
                  );
                }
              },
            )));
  }
}

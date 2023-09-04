import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/firebase/services/firestore_services.dart';
import 'package:emart_app/view/orders_screen/order_detail_screen.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Order".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getAllOrders(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor)));
          } else if (snapshot.data!.docs.isEmpty) {
            return "No Order yet!"
                .text
                .color(darkFontGrey)
                .fontFamily(semibold)
                .makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: "${index + 1}"
                      .text
                      .xl2
                      .fontFamily(bold)
                      .color(darkFontGrey)
                      .make(),
                  title: data[index]['order_code']
                      .toString()
                      .text
                      .color(redColor)
                      .fontFamily(bold)
                      .make(),
                  subtitle: data[index]['total_amount']
                      .toString()
                      .numCurrency
                      .text
                      .fontFamily(semibold)
                      .make(),
                  trailing: IconButton(
                    onPressed: () {
                      Get.to(() => OrderDetailscreen(
                            data: data[index],
                          ));
                    },
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                    color: darkFontGrey,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

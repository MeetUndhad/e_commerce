import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/Widget_common/bg_widget.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/firebase/services/firestore_services.dart';
import 'package:emart_app/view/home_Screen/category/item_detail.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class CategoryDetail extends StatefulWidget {
  final String? title;
  const CategoryDetail({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subCat.contains(title)) {
      productmethod = FireStoreServices.subCategoryProduct(title);
    } else {
      productmethod = FireStoreServices.getProduct(title);
    }
  }

  final controller = Get.find<ProductController>();

  dynamic productmethod;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: widget.title!.text.white.fontFamily(bold).size(18).make(),
            ),
            body: StreamBuilder(
              stream: productmethod,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: "Products Are Not Found".text.color(fontGrey).make(),
                  );
                } else {
                  var data = snapshot.data!.docs;
                  return Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                controller.subCat.length,
                                (index) => "${controller.subCat[index]}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .size(12)
                                    .makeCentered()
                                    .box
                                    .white
                                    .size(110, 60)
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .rounded
                                    .make()
                                    .onTap(() {
                                  switchCategory("${controller.subCat[index]}");
                                  setState(() {});
                                }),
                              ),
                            )),
                        20.heightBox,
                        Expanded(
                            child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 7,
                            mainAxisExtent: 250,
                          ),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  data[index]['p_images'][0],
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.fill,
                                ),
                                "${data[index]['p_name']}"
                                    .text
                                    .color(darkFontGrey)
                                    .fontFamily(semibold)
                                    .make(),
                                "${data[index]['p_prices']}"
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .size(16)
                                    .make()
                              ],
                            )
                                .box
                                .white
                                .outerShadowSm
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .rounded
                                .padding(const EdgeInsets.all(9))
                                .make()
                                .onTap(() {
                              controller.checkIfFav(data[index]);
                              Get.to(() => ItemDetails(
                                    title: data[index]['p_name'],
                                    data: data[index],
                                  ));
                            });
                          },
                        ))
                      ],
                    ),
                  );
                }
              },
            )));
  }
}

import 'dart:io';
import 'package:fruit_hub/screens/home_screens/controller/cart_controller.dart';

import '../../../utils/imports/imports.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Fetchdata extends StatefulWidget {
  const Fetchdata({super.key});

  @override
  State<Fetchdata> createState() => _FetchdataState();
}

class _FetchdataState extends State<Fetchdata> {
  CartController controller = Get.put(CartController());
  Stream? ref;
  CollectionReference collectionReference =
  FirebaseFirestore.instance.collection('products');
  var idd = FirebaseFirestore.instance.collection('products').doc().id.toString();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _reference =
  FirebaseFirestore.instance.collection('products').snapshots();
  final men = FirebaseFirestore.instance
      .collection('products')
      .where('categoryname', isEqualTo: 0)
      .snapshots();
  final women = FirebaseFirestore.instance
      .collection('products')
      .where('categoryname', isEqualTo: 1)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    print(" heyy ${collectionReference.doc().id}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fetch Data"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          StreamBuilder(
              stream: _reference,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ));
                }
                if (snapshot.hasError) {
                  return const Text("Error");
                }
                return Flexible(
                  flex: 2,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        var data = snapshot.data!.docs[index];
                        File? imageFile = File(data['image']);
                        return Container(
                          height: 183.h,
                          width: 152.w,
                          margin: EdgeInsets.only(right: 15),
                          child: Column(
                            children: [
                              Stack(
                                fit: StackFit.loose,
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: 80.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: Image.network(imageFile.path).image),
                                    ),
                                  ),
                                  Positioned(
                                      left: 90.w,
                                      top: 0.h,
                                      child: Icon(Icons.favorite_border, color: BackgroundColor,))
                                ],
                              ),
                              SizedBox(height: 8.h,),
                              SimpleText(data['productName'].toString()),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("\$${data['price']}", style: TextStyle(color: BackgroundColor, fontSize: 18.sp),),
                                  // Container(
                                  //     height: 40,
                                  //     width: 40,
                                  //     decoration: BoxDecoration(
                                  //         shape: BoxShape.circle,
                                  //         color: BackgroundColor.withOpacity(0.1)
                                  //     ),
                                  //     child: IconButton(onPressed: (){
                                  //       cartController.addProduct(productController.products[index]);
                                  //     }, icon: Icon(Icons.add, color: BackgroundColor,)))
                                ],
                              )
                            ],
                          ),
                        );

                      })),
                );
              }),
          Container(
            height: 40,
            color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    ref = men;
                    setState(() {});
                  },
                  child: const Text(
                    "MEN",
                  ),
                ),
                InkWell(
                  onTap: () {
                    ref = women;
                    setState(() {});
                  },
                  child: const Text("WOMEN"),
                ),
              ],
            ),
          ),
          StreamBuilder(
              stream: ref ?? _reference,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ));
                }
                if (!snapshot.hasData) {
                  return const Text("Error");
                }
                return Expanded(
                  flex: 3,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 3),
                          crossAxisCount: 2),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        var data = snapshot.data!.docs[index];
                        File? imageFile = File(data['image']);
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                                foregroundImage: imageFile == null
                                    ? Image.asset("assets/images/person.png")
                                    .image
                                    : Image.network(imageFile.path).image),
                            subtitle: Text(data['categoryname'].toString()),
                            // trailing: InkWell(
                            //   onTap: (() {
                            //
                            //     collectionReference
                            //         .doc(snapshot.data!.docs[index].id
                            //         .toString())
                            //         .delete();
                            //   }),
                            //   child: const Icon(
                            //     Icons.delete_outline_outlined,
                            //     color: Colors.red,
                            //   ),
                            // ),
                          ),
                        );
                      })),
                );
              }),
        ],
      ),
    );
  }
}

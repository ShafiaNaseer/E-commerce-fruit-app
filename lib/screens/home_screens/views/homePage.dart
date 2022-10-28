
import 'dart:io';

import 'package:badges/badges.dart';


import '../../../../utils/imports/imports.dart';
import '../../../widgets/drawer.dart';
import 'cart_screen.dart';
import '../controller/controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
 final productController = Get.put(ProductController());
  ProfileController controller = Get.put(ProfileController());

  Stream? ref;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('products');
  var idd = FirebaseFirestore.instance.collection('products').doc().id.toString();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final _reference =
  FirebaseFirestore.instance.collection('products').snapshots();
  final hottest = FirebaseFirestore.instance.collection('products').where('categoryname', isEqualTo: 0).snapshots();
  final popular = FirebaseFirestore.instance.collection('products').where('categoryname', isEqualTo: 1).snapshots();
  final newCombo = FirebaseFirestore.instance.collection('products').where('categoryname', isEqualTo: 2).snapshots();
  final juices = FirebaseFirestore.instance.collection('products').where('categoryname', isEqualTo: 3).snapshots();
  Color _color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: drawerr(),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          icon: const Icon(Icons.drag_handle_outlined)),
                      InkWell(
                        onTap: (){
                        Get.to(()  => const CartScreen());
                        },
                        child: Column(
                          children: [
                            Image(
                              image: const AssetImage("assets/images/mybasket.png"),
                              height: 24.h,
                              width: 24.w,
                            ),
                            Text("My Basket",
                                style: TextStyle(
                                  fontFamily: 'Brandon Grotesque Bold',
                                  fontSize: 10.sp,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 257.w,
                    child: RichText(
                        text: TextSpan(
                            text: "Hello ${controller.username.value.toString()}, ",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: 'Brandon Grotesque',
                                color: Colors.black),
                            children: [
                          TextSpan(
                            text: "What fruit salad combo do you want today?",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: 'Brandon Grotesque Bold'),
                          )
                        ])),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  searchRow(searchController, "Search for fruit salad combos"),
                  const SizedBox(
                    height: 30,
                  ),
                  BoldText("Recommended Combo"),
                  const SizedBox(
                    height: 40,
                  ),

                  CatalogProduct(),
                  const SizedBox(
                    height: 20,
                  ),

                  Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            ref = hottest;
                            setState(() {
                            });
                          },
                          child: const Text(
                            "Hottest",
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            ref = popular;
                            setState(() {
                            });
                          },
                          child: const Text("Popular"),
                        ),
                        InkWell(
                          onTap: () {
                            ref = newCombo;
                            setState(() {
                            });
                          },
                          child: const Text("New Combo",
                        //   style: TextStyle(color: _color),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            ref = juices;
                            setState(() {
                            });
                          },
                          child: const Text("Juices"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
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
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: ((context, index) {
                                var data = snapshot.data!.docs[index];
                                File? imageFile = File(data['image']);
                                return Container(
                                  height: 203.h,
                                  width: 152.w,
                                  margin: EdgeInsets.only(right: 15),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),
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
                                                  image: Image.network(imageFile.path).image, fit: BoxFit.cover),
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
                                        mainAxisAlignment: MainAxisAlignment.start,
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

                ],
              ),
            ),
          ),
        ));
  }
}

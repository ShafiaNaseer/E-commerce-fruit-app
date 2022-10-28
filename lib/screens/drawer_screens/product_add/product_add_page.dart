import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fruit_hub/utils/constants.dart';
import 'package:fruit_hub/utils/imports/imports.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

class UploadData extends StatefulWidget {
  @override
  State<UploadData> createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  TextEditingController priceEditingController = TextEditingController();
  TextEditingController stockEditingController = TextEditingController();
  TextEditingController productEditingController = TextEditingController();
  SingleValueDropDownController categoryEditingController =
      SingleValueDropDownController();
  var formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  var newurl;
  bool isPic = false;
  File? imageFile;

  Future getImagefromcamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = File(image!.path);
      isPic = true;
    });
    imageupload();
  }

  Future imageupload() async {
    int date = DateTime.now().millisecondsSinceEpoch;
    firebaseStorage.Reference ref =
        FirebaseStorage.instance.ref().child('Products').child('/posts$date');
    firebaseStorage.UploadTask uploadTask = ref.putFile(imageFile!);
    await Future.value(uploadTask);
    newurl = await ref.getDownloadURL();
  }

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(image!.path);
    });
  }

  void dialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: BackgroundColor.withOpacity(0.6),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      getImagefromcamera();
                      Navigator.pop(context);
                    },
                    child: const ListTile(
                      dense: true,
                      iconColor: Colors.white,
                      leading: Icon(Icons.camera_alt_outlined),
                      title: Text(
                        "Camera",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getImage();
                      Navigator.pop(context);
                    },
                    child: const ListTile(
                      dense: true,
                      iconColor: Colors.white,
                      leading: Icon(Icons.photo_library_outlined),
                      title: Text(
                        "Gallery",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  void clearTextField() {
    productEditingController.clear();
    priceEditingController.clear();
    stockEditingController.clear();
    categoryEditingController.clearDropDown();
    imageFile?.delete(recursive: true);
}
  // function
  Future uploaddata(int category, String price, productname, stock) async {
    setState(() {
      showspinner = true;
    });
    CollectionReference ref = _firebaseFirestore.collection("products");
    try {
      await imageupload();
      return await ref.add({
        'categoryname': category,
        'image': newurl,
        'price': price,
        'productName': productname,
        'stockCount': stock
      }).then((value) {
        Fluttertoast.showToast(
            msg: "Data Uploaded",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: BackgroundColor,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          showspinner = false;
        });
      }).catchError((error) => Fluttertoast.showToast(
            msg: error.message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          ));
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

// List <String> categories = [
//   "Fruit Salad Combo",
//   "Fruit Ice Cream",
//   "Creamy Fruit Salad",
//   "Popular",
// ];
  bool showspinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image(),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.w, vertical: 10.h),
                        child: DropDownTextField(
                          controller: categoryEditingController,
                          clearOption: true,
                          enableSearch: true,
                          clearIconProperty: IconProperty(color: Colors.green),
                          textFieldDecoration: InputDecoration(
                            filled: true,
                            fillColor: TextfieldColor,
                            labelText: "Category",
                            contentPadding: EdgeInsets.all(15),
                            labelStyle: TextStyle(color: Colors.black45),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
                          ),
                          searchDecoration:
                              const InputDecoration(hintText: "Categories"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Category is Required";
                            } else {
                              return null;
                            }
                          },
                          dropDownItemCount: 4,
                          dropDownList: const [
                            DropDownValueModel(name: 'Hottest', value: 0),
                            DropDownValueModel(
                              name: 'Popular',
                              value: 1,
                            ),
                            DropDownValueModel(
                              name: 'New Combo',
                              value: 2,
                            ),
                            DropDownValueModel(name: 'Top', value: 3),
                          ],
                          onChanged: (val) {
                            setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.w, vertical: 10.h),
                        child: TextFormField(
                          controller: productEditingController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Product Name is Required";
                            }
                          },
                       //   autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: customInputDecoration("Product Name"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.w, vertical: 10.h),
                        child: TextFormField(
                          controller: priceEditingController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Price is Required";
                            }
                          },
                         // autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: customInputDecoration("Price"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.w, vertical: 10.h),
                        child: TextFormField(
                          controller: stockEditingController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Stock Quantity is Required";
                            }
                          },
                       //   autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: customInputDecoration("Stoke Quantity"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await uploaddata(
                                  categoryEditingController
                                      .dropDownValue!.value,
                                  priceEditingController.text,
                                  productEditingController.text,
                                  stockEditingController.text);
                              clearTextField();
                            }
                          },
                          child: ButtonContainer('Upload Data'),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _image() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: (100),
                    height: (100),
                    child: FittedBox(
                      child: Stack(children: [
                        CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: imageFile == null
                                ? Image.asset("assets/images/person_bg.png")
                                    .image
                                : Image.file(imageFile!).image,
                            foregroundImage: imageFile == null
                                ? Image.asset("assets/images/person_bg.png")
                                    .image
                                : Image.file(imageFile!).image),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 25,
                          ),
                          child: SizedBox(
                            height: 15,
                            width: 15,
                            child: FloatingActionButton(
                              mini: true,
                              isExtended: true,
                              onPressed: () {
                                dialog(context);
                              },
                              backgroundColor: BackgroundColor,
                              child: const Icon(
                                Icons.add_a_photo_outlined,
                                size: 10,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ]),
          ),
        ),
      ],
    );
  }

}

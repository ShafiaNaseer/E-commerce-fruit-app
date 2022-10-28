// import 'dart:html';
//
// import '../../../utils/imports/imports.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
// class ProductAddController extends GetxController {
//   var newurl;
//   bool isPic = false;
//   // File? imageFile;
//   RxString image = "".obs;
//
//   pickImageFromGallery() async {
//     PickedFile? pickedFile =  await ImagePicker.platform.pickImage(source: ImageSource.gallery);
//     print("Picked Image: $pickedFile");
//      image = File(pickedFile!.path) as RxString;
//     print("image: $image");
//     this.image.value=image.path;
//     imageupload(image);
//   }
//
//   pickImageFromCamera() async {
//     PickedFile? pickedFile =  await ImagePicker.platform.pickImage(source: ImageSource.camera);
//
//     print("Picked Image: $pickedFile");
//
//     File? image = File(pickedFile!.path);
//     print("image: $image");
//     this.image.value=image.path;
//     imageupload(image);
//   }
//
//
//
//
//
//   Future imageupload(imageFile) async {
//     int date = DateTime.now().millisecondsSinceEpoch;
//     firebaseStorage.Reference ref = FirebaseStorage.instance.ref().child('Products').child('/posts$date');
//     firebaseStorage.UploadTask uploadTask = ref.putFile(imageFile);
//     await Future.value(uploadTask);
//     newurl = await ref.getDownloadURL();
//   }
//
//
//
// }
//




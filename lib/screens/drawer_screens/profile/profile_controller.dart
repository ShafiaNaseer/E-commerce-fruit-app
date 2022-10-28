import 'dart:io';
import '../../../utils/imports/imports.dart';

class ProfileController extends GetxController {
RxString image = "".obs;
RxString username = "".obs;
RxString useremail = "".obs;
RxString userimage = "".obs;
RxString userphone = "".obs;

@override
void onInit(){
  getValidationData();
  super.onInit();
}

getValidationData() async {
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  String name = sharedPreferences.getString('name')!;
  String image = sharedPreferences.getString('image')!;
  String phone = sharedPreferences.getString('phone')!;
  String email = sharedPreferences.getString('email')!;
  username.value = name;
  userimage.value = image;
  userphone.value = phone;
  useremail.value = email;
  update();
}
  pickImageFromGallery() async {
    PickedFile? pickedFile =  await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    print("Picked Image: $pickedFile");
    File? image = File(pickedFile!.path);
    print("image: $image");
    this.image.value=image.path;
    imageUpload(image);
  }
  pickImageFromCamera() async {
    PickedFile? pickedFile =  await ImagePicker.platform.pickImage(source: ImageSource.camera);
    print("Picked Image: $pickedFile");
    File? image = File(pickedFile!.path);
    print("image: $image");
    this.image.value=image.path;
    imageUpload(image);
  }
  Future imageUpload (imageFile) async{
    var currentUser = FirebaseAuth.instance.currentUser;
    print("currrent id ${currentUser!.uid}");
    try{
      FirebaseStorage storage = FirebaseStorage.instance;
      int date = DateTime.now().millisecondsSinceEpoch;
      Reference ref = storage.ref().child("users_profile").child('/posts$date');
      UploadTask uploadTask = ref.putFile(imageFile);
      await Future.value(uploadTask);
      var link = await ref.getDownloadURL();
      CollectionReference users = FirebaseFirestore.instance.collection('Users');
      await users.doc(currentUser.uid).update({
        'user-pic': link.toString()
      }).then((value) => Get.snackbar(
          "Profile Picture Uploaded", "",
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2)));
      print('link $link');
    }catch(e){
      Get.snackbar(
          "There is an issue While Uploading your image", "Select an Image",
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2));
    }
  }
}
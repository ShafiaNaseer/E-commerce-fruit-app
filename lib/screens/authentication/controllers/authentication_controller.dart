import '../../../utils/imports/imports.dart';
import '../../home_screens/views/homePage.dart';
import '../screens/login.dart';

class AuthenticationController  extends GetxController {

  static signUp(BuildContext context, username, useremail, userpassword, userphone) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.createUserWithEmailAndPassword(
          email: useremail, password: userpassword);

      storedDataInFirestore(username, useremail, userpassword, userphone);
      print("Email: $useremail");
      Get.off(LogIn());

      print("End");
    } on FirebaseAuthException catch (e) {
      print("Firebase Exception: ${e.code}");
      if (e.code == "invalid-email") {
        Get.snackbar(
            "Kindly enter valid Email address", "",
            snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2));
        print("Kindly enter valid Email address");
      } else if (e.code == "weak-password") {
        Get.snackbar(
            "Weak Password", "",
            snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2));
        print("Password should be greater then 6 charactor");
      } else if (e.code == "email-already-in-use") {
        Get.snackbar(
            "Email already exist", "",
            snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2));
        print("Email already exist");
      }
    } catch (e) {
      print("e: $e");
    }
  }

  static read() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var collection = FirebaseFirestore.instance.collection('Users');
      var docSnapshot = await collection.doc(firebaseAuth.currentUser!.uid).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        String name = data?['name'];
        String image = data?['user-pic'];
        String email = data?['email'];
        String phone = data?['phoneno'];

        print("name is $name");
        print("Email is $email");

        prefs.setString('name', name);
        prefs.setString('image', image);
        prefs.setString('email', email);
        prefs.setString('phone', phone);

        print(prefs.getString('name'));
        print(prefs.getString('email'));
        print(prefs.getString('phone'));
        print(prefs.getString('image'));
      }
      print("End");
    } on FirebaseAuthException catch (e) {
      print("Firebase Exception: ${e.code}");

    } catch (e) {
      print("e: $e");
    }
  }

  static storedDataInFirestore(name, email, password, phoneno) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var uid = firebaseAuth.currentUser!.uid;
      await firebaseFirestore.collection("Users").doc(uid.toString()).set({
        "user-id": uid,
        "name": name,
        "email": email,
        "password": password,
        "phoneno": phoneno,
      });
      Get.snackbar(
          "Your account has been created successfully", "",
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2));
      print("Data Save Successfully");
    } catch (e) {
      print("e $e");
    }
  }

  static signIn(BuildContext context, userEmail, userPassword) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await firebaseAuth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
      prefs.setBool('isLogin', true);
      Get.off( HomePage());
      read();
    } on FirebaseAuthException catch (ex) {
      print("Firebase Login Exception $ex");
    } catch (e) {
      print("e $e");
    }
  }
}



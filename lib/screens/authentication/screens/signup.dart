import 'package:fruit_hub/screens/authentication/controllers/authentication_controller.dart';
import 'package:fruit_hub/screens/authentication/screens/login.dart';

import '../../../utils/imports/imports.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool isVisible = true;
  bool isView = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100.h,
            ),
            BoldText("Hello"),
            SimpleText("Tell us about yourself!"),
            SizedBox(
              height: 20.h,
            ),
          Form(
              key: formKey,
              child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name is Required";
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: customInputDecoration('Name'),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is Required";
                      } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: customInputDecoration("Email")),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Phone Number is Required";
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: customInputDecoration('Phone Number'),
                  )),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                  ),
                  child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is Required";
                        } else if (value.length <= 4) {
                          return "Password should be greater than 4 latter";
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: isVisible,
                      decoration: customInputDecoration("Password"))),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                  child: TextFormField(
                      controller: confirmPassword,
                      validator: (valuee) {
                        if (valuee!.isEmpty) {
                          return "Password is Required";
                        } else if (valuee.length <= 5) {
                          return "Password should be greater than 5 latter";
                        } else if (passwordController.text !=
                            confirmPassword.text) {
                          return "Password not Match";
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: isView,
                      decoration: customInputDecoration("Confirm Password"))),
              SizedBox(
                height: 20.h,
              ),
              InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      AuthenticationController.signUp(
                          context,
                          nameController.text,
                          emailController.text,
                          passwordController.text,
                          phoneController.text);
                    }
                  },
                  child: ButtonContainer("Continue")),
            ],
          )),

            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SimpleText("Already have an account?"),
                TextButton(
                    onPressed: () {
                      Get.off(LogIn());
                    },
                    child: SimpleText("Log In"))
              ],
            )),
          ],
        ),
      ),
    );
  }
}

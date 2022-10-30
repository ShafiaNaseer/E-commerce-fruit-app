

import '../../../utils/imports/imports.dart';
import '../controllers/authentication_controller.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 210.h,
            ),
            BoldText("Glad to see you"),
           SimpleText("Sign in to your account and get started"),
            SizedBox(
              height: 20.h,
            ),
          Form(
              key: formKey,
              child: Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, ),
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
                  decoration: customInputDecoration("Email")
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 25.w, vertical: 20.h),
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
                    decoration: customInputDecoration("Password")
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SimpleText("Forgot Password?"),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
                onTap: (){
                  if(formKey.currentState!.validate()) {
                    AuthenticationController.signIn(
                        context, emailController.text, passwordController.text);
                  }
                },
                child: ButtonContainer("Login")),
          ],)),

            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SimpleText("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: SimpleText("Sign Up"))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

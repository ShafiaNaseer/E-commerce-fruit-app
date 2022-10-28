import 'package:fruit_hub/screens/authentication/screens/login.dart';

import '../../../utils/imports/imports.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 375.w,
                height: 469.h,
                color: BackgroundColor,
                child: Stack(
                  children: [
                    Center(
                        child: Image(
                      image: AssetImage('assets/images/imagebasket.png'),
                      height: 250.h,
                      width: 270.w,
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 56.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25.w,
                ),
                child: BoldText("Get The Freshest Fruit Salad Combo")
              ),
              SizedBox(
                height: 8.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25.w,
                ),
                child: SimpleText("We deliver the best and freshest fruit salad in town. Order for a combo today!!!")
              ),
              SizedBox(
                height: 58.h,
              ),
              Center(
                child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogIn()));
                    },
                    child: ButtonContainer("Let’s Continue"))
              )
            ],
          ),
        ),
      ),
    );
  }
}

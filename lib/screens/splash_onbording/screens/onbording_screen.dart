import 'package:fruit_hub/screens/authentication/screens/login.dart';

import '../../../utils/imports/imports.dart';
import '../onbording_model/model.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  controller: _controller,
                  itemCount: contents.length,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: 20.h),
                      child: Column(
                        children: [
                          Container(
                            height: 450.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage(contents[i].image,), fit: BoxFit.cover)
                            ),
                            ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            contents[i].title,
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontFamily: 'Brandon Grotesque Bold',
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            contents[i].description,
                            style: TextStyle(
                              fontSize: 16.sp,
                                fontFamily: 'Brandon Grotesque',
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    );
                  }),
            ),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    contents.length,
                        (index) => buildDot(index, context),
                  )),
            ),
            Container(
              height: 60.h,
              margin: EdgeInsets.only(top: 20.h,  left: 40.w, right: 40.w,),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (currentIndex == contents.length - 1) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => LogIn()));
                  }
                  _controller.nextPage(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.bounceIn);
                },
                child: Text('Get Started'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: BackgroundColor,
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: 'Brandon Grotesque'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => LogIn()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.black87,
                              decoration: TextDecoration.underline),
                        ))
                  ],
                )),
            SizedBox(height: 5.h,),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10.h,
      width: currentIndex == index ? 25.w : 10.w,
      margin: EdgeInsets.only(right: 5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: BackgroundColor,
      ),
    );
  }
}

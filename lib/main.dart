


import 'package:fruit_hub/screens/authentication/screens/login.dart';
import 'package:fruit_hub/screens/home_screens/widgets/category_product.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import '../../../utils/imports/imports.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(  const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context , child) => GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: child,
        theme: ThemeData(
          fontFamily: 'Brandon Grotesque',
          appBarTheme: AppBarTheme(
            color: BackgroundColor,
            centerTitle: true
          )
        ),
      ),
      child:  HomePage(),
      designSize: Size(375, 812),
    );
  }
}


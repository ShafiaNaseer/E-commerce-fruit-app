import 'package:fruit_hub/screens/authentication/screens/login.dart';

import '../../../utils/imports/imports.dart';
import '../screens/drawer_screens/product_add/product_add_page.dart';
import '../screens/drawer_screens/profile/profile_screen.dart';

class drawerr extends StatelessWidget {
  drawerr({Key? key}) : super(key: key);
ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: BackgroundColor,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.orange,
                  radius: 30,
                  backgroundImage: NetworkImage(controller.userimage.value.toString()),
                ),
                SizedBox(height: 15,),
                Text(controller.username.value.toString(), style: textStyle(),),
                Text(controller.useremail.value.toString(), style: textStyle(),)
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home), title: Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person_rounded), title: Text("Profile"),
            onTap: () {
              Get.to(Profile_Screen());
            },
          ),
          ListTile(
            leading: Icon(Icons.add_moderator_sharp), title: Text("Add Product"),
            onTap: () {
              Get.to(UploadData());
            },
          ),
          ListTile(
            leading: Icon(Icons.contacts), title: Text("Contact Us"),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          Divider(),
          ListTile(
            leading: Icon(Icons.logout), title: Text("Logout"),
            onTap: () async {
              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
         //     sharedPreferences.remove('isLogin');
              sharedPreferences.clear();
              Get.off(LogIn());
            },
          ),
        ],
      ),
    );
  }
}

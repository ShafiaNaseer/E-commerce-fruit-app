import 'dart:io';

import '../../../utils/imports/imports.dart';

class Profile_Screen extends StatelessWidget {
  Profile_Screen({Key? key}) : super(key: key);
  ProfileController controller = Get.put(ProfileController());


  @override
  Widget build(BuildContext context) {
    print("profile pic ${controller.userimage.value.toString()}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Obx(
                      () => Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: CircleAvatar(
                      radius: 63,
                      backgroundColor: BackgroundColor,
                      child:
                      controller.image.value.toString()==null?
                      CircleAvatar(
                       // backgroundColor: Colors.grey,
                        radius: 60,
                        backgroundImage:Image.asset("assets/images/person.png").image)
                      :CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 60,
                        backgroundImage: controller.image.value.toString() == null?
                        FileImage(File(controller.image.value.toString())):
                        Image.network(controller.userimage.value.toString() ).image

                      ),
                    ), 
                  ),
                ),
                Positioned(
                    top: 25,
                    left: 105,
                    child: RawMaterialButton(
                        elevation: 10,
                        fillColor: BackgroundColor,
                        shape: CircleBorder(),
                        child: Icon(Icons.edit, color:  Colors.white,),
                        padding: EdgeInsets.all(6.0),
                        onPressed: (() {
                          showDialog(
                              context: context,
                              builder: (BuildContext b) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ShowDialog(),
                                );
                              });
                        }))),
              ],
            ),
            SizedBox(
              height: 20,
            ),
             Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              child: ListTile(
                title: BoldText("Name"),
                subtitle: Obx(() => SimpleText(" ${controller.username.value.toString()}")),
                trailing: Icon(Icons.edit),

              ),
            ),


            SizedBox(
              height: 20,
            ),
            Obx(() => Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              child: ListTile(
                title: BoldText("Phone Number"),
                subtitle: SimpleText(" ${controller.userphone.value.toString()}"),
                trailing: Icon(Icons.edit),

              ),
            )
            ),

            SizedBox(
              height: 20,
            ),
            Obx(() => Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              child: ListTile(
                title: BoldText("Email Address"),
                subtitle: SimpleText(" ${controller.useremail.value.toString()}"),
                trailing: Icon(Icons.edit),

              ),
            )
            ),

          ],
        ),
      )
    );
  }
}

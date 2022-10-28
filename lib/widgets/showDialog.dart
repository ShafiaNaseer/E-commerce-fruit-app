import 'package:flutter/material.dart';
import 'package:fruit_hub/utils/imports/imports.dart';
import 'package:get/get_core/src/get_main.dart';
import '../screens/drawer_screens/profile/profile_controller.dart';

class ShowDialog extends StatelessWidget {
  ShowDialog({Key? key}) : super(key: key);
  ProfileController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.23,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: BackgroundColor.withOpacity(0.4),

      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
           BoldText('Choose Option'),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: ListBody(
                children: [
                  InkWell(
                    onTap: (() async {
                      await controller
                          .pickImageFromGallery();
                      Get.back();
                    }),
                    splashColor: Colors.grey,
                    child: Padding(
                      padding:
                      const EdgeInsets.all(
                          8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.photo_library_outlined,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                              'Select from Gallery',
                              style: TextStyle(
                                  color: Colors
                                      .black)),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (() async {
                      await controller
                          .pickImageFromCamera();
                      Get.back();
                    }),
                    splashColor: Colors.grey,
                    child: Padding(
                      padding:
                      const EdgeInsets.all(
                          8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                              'Select from Camera',
                              style: TextStyle(
                                  color: Colors
                                      .black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

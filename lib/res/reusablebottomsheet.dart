
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:flutter/material.dart';




reuablebottomsheet(BuildContext context, String title, Function gallaryontap,
    Function cameraontap) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.32,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("$title".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorController.btnColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  fontFamily: 'tutorPhi'
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                    onTap: () {
                      gallaryontap();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.photo,
                          color: colorController.btnColor,
                          size: 70,
                        ),
                        Text("Gallery",
                            style: TextStyle(
                                color: colorController.btnColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ],
                    )),
                InkWell(
                    onTap: () {
                      cameraontap();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.camera,
                          color: colorController.btnColor,
                          size: 70,
                        ),
                        Text("Camera",
                            style: TextStyle(
                                color: colorController.btnColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ],
                    ))
              ],
            ),
          ],
        ),
      );
    },
  );
}



import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:flutter/material.dart';

reusableSelectedItem(BuildContext context,List<String> items,Function(int index) ontap,){
  return Container(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * items.length),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 10.0, // Spacing between columns
                        mainAxisSpacing: 10.0, // Spacing between rows
                        childAspectRatio: 5.1, // Aspect ratio of each grid item
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: colorController.qualificationItemsColors,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  items[index],
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 13, color: colorController.whiteColor),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  ontap(index);
                                  // setState(() {
                                  //   // Remove the selected item from the list
                                  //   selectedIdsGroup.removeAt(index);
                                  //   selectedNamesGroup.removeAt(index);
                                  //   // updateSelectedNames(); // Update the names here
                                  // });
                                },
                                child: Icon(Icons.cancel_outlined, color: colorController.whiteColor,size: MediaQuery.of(context).size.width*.050,),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
}
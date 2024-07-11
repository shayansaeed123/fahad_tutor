import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  List<dynamic> tuitions = [];
  bool isLoading = false;
  bool isLoading2 = false;
  bool visible = true;
  String g_id = '';
  String tuition_id = '';
  int success = 0;
  int is_apply = 0;
  String msg = '';
  int start = 0;
  int limit = 10;
  TutorRepository repository = TutorRepository();
  @override
  void initState() {
    super.initState();
    fetchNotification();
  }  

  Future<void> fetchNotification() async {
    setState(() {
      isLoading2 = true;
    });
    await repository.getNotification(start);
    setState(() {
      tuitions = repository.allNotificationList;
    });
    setState(() {
      isLoading2 = false;
    });
  }

  Future<void> loadMoreNotification() async {
    setState(() {
      isLoading = true;
    });
    start += limit;
    await repository.getNotification(start);
    setState(() {
      tuitions = repository.allNotificationList;
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: colorController.whiteColor,
    appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,
    leading:  Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      child: InkWell(
        onTap: (){Navigator.pop(context);},
        child: Image.asset('assets/images/gradient_back.png',fit: BoxFit.contain,height: MediaQuery.of(context).size.height * 0.02,)),
    ),),
    body: Padding(
      padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .032),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          reusableText('Notifications',color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
          reusablaSizaBox(context, 0.030),
          Expanded(
            child: ListView.builder(
              itemCount: tuitions.length + 1,
              itemBuilder: (context, index) {
                if (index < tuitions.length) {
                    var data = tuitions[index];
                    var remarks = data['remarks'];
                    var type = data['type'];
                    var title = data['title'];
                    var datetime = data['datetime'];
                    return Container(
                      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .025),
                decoration: BoxDecoration(
                  color: colorController.whiteColor,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: colorController.grayTextColor,blurRadius: 4.0,offset: Offset(0, 2),
                      ),],),
                child: ListTile(
                  leading: Image.asset('assets/images/not_img.png',fit: BoxFit.contain,),
                  title: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    reusableText('$title',color: colorController.blackColor,fontsize: 15),
                    reusablaSizaBox(context, 0.003),
                    reusableText('$remarks',color: colorController.blackColor,fontsize: 13),
                    reusablaSizaBox(context, 0.007),
                  ],),
                  subtitle: reusableText('$datetime',color: colorController.blackColor,fontsize: 11),
                  trailing: type == '0' ? Image.asset('assets/images/view.png',fit: BoxFit.contain,height: MediaQuery.of(context).size.height * 0.04,) : Container(),
                ),
              );
                  }else{
                    return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width * .32,
                                vertical: MediaQuery.of(context).size.height * .03,
                              ),
                              child: isLoading
                                  ? reusableloadingrow(context, isLoading)
                                  : repository.showLoadMoreButton
                                      ? reusableBtn(
                                          context, 'Load More', () {
                                          loadMoreNotification();
                                        })
                                      : Center(
                                      child: CircularProgressIndicator(
                                      color: colorController.btnColor,
                                    )),
                            );
                  }
              
            },),
          )
        ],
      ),
    )
  );
  }
}
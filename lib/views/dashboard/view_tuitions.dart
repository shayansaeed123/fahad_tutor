

import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewTuitions extends StatefulWidget {
  const ViewTuitions({super.key});

  @override
  State<ViewTuitions> createState() => _ViewTuitionsState();
}

class _ViewTuitionsState extends State<ViewTuitions> {

TutorRepository repository =  TutorRepository();

int start = 0;
int limit = 10;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    repository.fetchTuitions(start, limit);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(future: repository.fetchTuitions(start, limit), builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var data = snapshot.data![index];
            print('object $data');
            print('wah wah ${data['class_name']}');
            MySharedPrefrence().setViewTuitions(data);
          },);
        },),
      ),
    );
  }
}
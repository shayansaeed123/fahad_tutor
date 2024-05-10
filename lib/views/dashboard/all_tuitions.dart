


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllTuitions extends StatefulWidget {
  const AllTuitions({super.key});

  @override
  State<AllTuitions> createState() => _AllTuitionsState();
}

class _AllTuitionsState extends State<AllTuitions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("All Tuitions"),
      ),
    );
  }
}


import 'package:flutter/material.dart';

reusablepopup(BuildContext context,String image)async{
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                // width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(image,fit: BoxFit.fill,)
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 4,
                right: 2,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); 
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset('assets/images/remove.png',fit: BoxFit.contain,width: MediaQuery.of(context).size.width*0.08,)
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
}
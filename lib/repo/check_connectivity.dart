

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

checkConnection(
  AsyncSnapshot snapshot,
  Widget widget){
  switch(snapshot.connectionState){
      case ConnectionState.active:
        final state = snapshot.data!;
        switch(state){
          case ConnectivityResult.none:
            return Center(
              child: Image.asset('assets/images/no_internet.jpg',fit: BoxFit.cover,filterQuality: FilterQuality.high,)
            );
          default:
            return widget;
        }
      default:
        return Container();
    }
}

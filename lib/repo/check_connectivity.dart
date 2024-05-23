

chechConnection(Asyn){
  switch(snapshot.connectionState){
      case ConnectionState.active:
        final state = snapshot.data!;
        switch(state){
          case ConnectivityResult.none:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.signal_wifi_connected_no_internet_4_outlined, size: 50,),
                  SizedBox(height: 10,),
                  Text("No Internet Connection", style: TextStyle(color: Colors.black,fontSize: 30),)
                ],
              ),
            );
          default:
            return widget;
        }
      default:
        return Container();
    }
}

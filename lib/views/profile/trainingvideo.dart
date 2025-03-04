import 'dart:convert';

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrainingVideos extends StatefulWidget {
  const TrainingVideos({super.key});

  @override
  State<TrainingVideos> createState() => _TrainingVideosState();
}

class _TrainingVideosState extends State<TrainingVideos> {
  bool isLoading = false;
  List<dynamic> VideoData = [];
  late List<YoutubePlayerController> _controllers;

  Future<List<dynamic>> getData()async{
    setState(() {
      isLoading = true;
    });
    try{
      String url =
          '${Utils.baseUrl}trainingvideoslinks.php';
      final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      setState(() {
        VideoData = jsonResponse;
      }); 
      return VideoData;
    } else {
      throw Exception('Failed to load Data');
    }
    }catch(e){
      print(e.toString());
      return [];
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    // _initializeYouTubeControllers();
  }
  // void _initializeYouTubeControllers() {
  //   _controllers = VideoData.map((video) {
  //     final videoId = YoutubePlayer.convertUrlToId(video['url']);
  //     return YoutubePlayerController(
  //       initialVideoId: videoId ?? "", // Fallback to empty if null
  //       flags: YoutubePlayerFlags(
  //         autoPlay: false,
  //         useHybridComposition: true, // Force Hybrid Composition
  //         mute: false,
  //       ),
  //     );
  //   }).toList();
  // }

  // @override
  // void dispose() {
  //   for (var controller in _controllers) {
  //     controller.dispose(); // Prevent memory leaks
  //   }
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return reusableprofileidget(context, Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .032),
      child: SingleChildScrollView(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Videos',
        style: TextStyle(
          color: colorController.blackColor,
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 10),
      ListView.builder(
        shrinkWrap: true, // ✅ Prevent unbounded height error
        physics: NeverScrollableScrollPhysics(), // ✅ Disable scrolling
        itemCount: VideoData.length,
        itemBuilder: (context, index) {
          final video = VideoData[index];
          final videoId = YoutubePlayer.convertUrlToId(video['url'])!;

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video['title'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: YoutubePlayer(
                      controller: YoutubePlayerController(
                        initialVideoId: videoId,
                        flags: YoutubePlayerFlags(autoPlay: false),
                      ),
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ],
  ),
)

    ), reusableloadingrow(context, isLoading));
  }
}
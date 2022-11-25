import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitnass_app_api/model/exercise_model.dart';
import 'package:fitnass_app_api/widget/detalisfitnass.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class DetalisFitNass extends StatefulWidget {
  DetalisFitNass({Key? key, required this.exerciseModel, this.second})
      : super(key: key);

  ExerciseModel exerciseModel;
  final int? second;

  @override
  State<DetalisFitNass> createState() => _DetalisFitNassState();
}

class _DetalisFitNassState extends State<DetalisFitNass> {
  late Timer timer;
  int startCount = 0;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == widget.second) {
        timer.cancel();
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      }
      setState(() {
        startCount = timer.tick;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FitNess",
          style: TextStyle(fontSize: 22),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 100,
              right: 20,
              left: 20,
              child: Center(
                  child: Text(
                "${startCount}",
                style: TextStyle(fontSize: 30, color: Colors.amber),
              )),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: "${widget.exerciseModel.gif}",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

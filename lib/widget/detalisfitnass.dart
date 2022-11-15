import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitnass_app_api/model/exercise_model.dart';
import 'package:fitnass_app_api/widget/detalisgif.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class DetlisFitNass extends StatefulWidget {
  DetlisFitNass({
    Key? key,
    required this.exerciseModel,
  }) : super(key: key);

  ExerciseModel exerciseModel;

  @override
  State<DetlisFitNass> createState() => _DetlisFitNassState();
}

class _DetlisFitNassState extends State<DetlisFitNass> {
  var secend = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("FitNess"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DetalisFitNass(exerciseModel: widget.exerciseModel)));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: "${widget.exerciseModel.thumbnail}",
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 20,
              right: 25,
              left: 20,
              child: SleekCircularSlider(
                min: 1,
                max: 20,
                initialValue: secend.toDouble(),
                onChange: (double value) {
                  secend = value.toInt();

                  // callback providing a value while its being changed (with a pan gesture)
                },
                onChangeStart: (double startValue) {
                  // callback providing a starting value (when a pan gesture starts)
                },
                onChangeEnd: (double endValue) {
                  // ucallback providing an ending value (when a pan gesture ends)
                },
                innerWidget: (double value) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$secend",
                        style: TextStyle(fontSize: 20, color: Colors.yellow),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print("wwwwwwwwwwwwwww $secend");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetalisFitNass(
                                    second: secend,
                                    exerciseModel: widget.exerciseModel,
                                  )));
                        },
                        child: Text("START"),
                        style: ElevatedButton.styleFrom(primary: Colors.orange),
                      )
                    ],
                  );
                  // use your custom widget inside the slider (gets a slider value from the callback)
                },
              ))
        ],
      ),
    ));
  }
}

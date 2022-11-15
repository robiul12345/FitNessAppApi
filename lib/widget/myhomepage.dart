import 'package:fitnass_app_api/model/exercise_model.dart';
import 'package:fitnass_app_api/widget/detalisfitnass.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ExerciseModel exerciseModel;
  List<ExerciseModel> alldata = [];

  getData() async {
    var link =
        "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR2nEqY-glGam1pIlPbpXNT62dUS9x12UVwqyqAbEGBqO-a9XJHaMXByRPQ";

    try {} catch (e) {}

    var responce = await http.get(Uri.parse(link));

    if (responce.statusCode == 200) {
      var data = jsonDecode(responce.body)["exercises"];

      for (var i in data) {
        exerciseModel = ExerciseModel(
            id: i["id"],
            title: i["title"],
            thumbnail: i["thumbnail"],
            gif: i["gif"],
            secind: i["seconds"]);
        setState(() {
          alldata.add(exerciseModel);

          print(alldata);
        });
      }
    }
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "FitNess",
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.separated(
            itemBuilder: (context, index) => Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetlisFitNass(
                                  exerciseModel: alldata[index],
                                )));
                      },
                      child: Container(
                          height: 200,
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: "${alldata[index].thumbnail}",
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          )),
                    ),
                    Positioned(
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 60,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          alignment: Alignment.bottomLeft,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.black,
                                    Colors.black54,
                                    Colors.transparent
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter)),
                          child: Text(
                            "${alldata[index].title}",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                        ))
                  ],
                ),
            separatorBuilder: (_, index) => SizedBox(),
            itemCount: alldata.length),
      ),
    ));
  }
}

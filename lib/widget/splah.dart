import 'package:fitnass_app_api/widget/myhomepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class SplahScrren extends StatefulWidget {
  const SplahScrren({Key? key}) : super(key: key);

  @override
  State<SplahScrren> createState() => _SplahScrrenState();
}

class _SplahScrrenState extends State<SplahScrren> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(
      seconds: 5,
      
    )).then((value){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage()));
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MyHomePage()), (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Color(0xff071D31),
      body: Container(child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [


          ClipRRect(
              borderRadius: BorderRadius.circular(12),

              child: Image.asset("images/fitnass.png")),

        SizedBox(
          height: MediaQuery.of(context).size.height*0.02,
        ),
        SpinKitSpinningLines(
          color: Colors.orange,
          size: 80.0,
        )
      ],),),
    ));
  }
}

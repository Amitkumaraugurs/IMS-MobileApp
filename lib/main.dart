import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'Login.dart';
import 'network/api_service.dart';
import 'package:logging/logging.dart';



void main() {
  _setupLogging();
  /*WidgetsFlutterBinding.ensureInitialized();   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]).then((_) {

  });*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Provider<ApiService>(
      create: (context) => ApiService.create(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.deepOrangeAccent,
            accentColor: Colors.deepOrange[400],
            accentColorBrightness: Brightness.dark
        ),
        home: MyHome(),
      ),
    );

  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) => {
    print("${rec.level.name}: ${rec.time} : ${rec.message}")
  });
}


/*void main() => runApp(MaterialApp(

    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
        accentColor: Colors.deepOrange[400],
        accentColorBrightness: Brightness.dark
    ),

    home: MyApp()
  ));


class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }



}*/

class MyHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return SplashState();
  }
}



class SplashState extends State<MyHome>{

@override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {

   return Scaffold(

     body: Container(
       decoration: BoxDecoration(
         image: DecorationImage(
           image: AssetImage("assets/mob-2.jpg"),
           fit: BoxFit.cover,
         ),

       ),
     ),

   );

  }

startTime() async {
  var duration = new Duration(seconds: 4);
  return new Timer(duration, route);
}


route() {
  Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => Login()
  )
  );
}
}
  /*@override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/mob-2.jpg"),
            fit: BoxFit.cover,
          ),

        ),
      )

    );
  }*/




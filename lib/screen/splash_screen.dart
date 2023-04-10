import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prcatice_1/util/constant.dart';
import 'package:provider/provider.dart';

import '../provider/AppLanguage.dart';
import 'home_screeb.dart';

class SplashScreen extends StatefulWidget {  
  @override  
  SplashScreenState createState() => SplashScreenState();  
}  
class SplashScreenState extends State<SplashScreen> {  
  bool isSwitched = false;
  @override  
  void initState() {  
    super.initState();  
    // Timer(Duration(seconds: 10),  
    //         ()=>Navigator.pushReplacement(context,  
    //         MaterialPageRoute(builder:  
    //             (context) => HomePage()  
    //         )  
    //      )  
    // );  
  }  
  @override  
  Widget build(BuildContext context) {  
     var appLanguage = Provider.of<AppLanguage>(context);
         return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/holly.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Text("القران الكريم", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 40),),
              )),
        
            SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: basic , textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      onPressed: (){
Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomePage())) ;
                    }, child: Text("ابدا")),
                  ),
                    Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text(isSwitched ? "ع" : "en" , style: TextStyle(color: Colors.white),),
                     ),
                     Switch(
                 value: isSwitched,
                 onChanged: (value) {
                   setState(() {
                     isSwitched = value;
                     if(isSwitched){
 appLanguage.changeLanguage(Locale("en"));
                     }else{
  appLanguage.changeLanguage(Locale("ar"));
                     }
                     print(isSwitched);
                   });
                 },
                 activeTrackColor: Colors.lightGreenAccent,
                 activeColor: Colors.green,
               ),
                  
                   ],
                 ),

                 Text("Developed by: sh@bib" , style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
             
          ],
        ) /* add child content here */,
      ),
    );
  }
}

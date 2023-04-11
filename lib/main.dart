import 'package:flutter/material.dart';
import 'package:quran/provider/AppLanguage.dart';
import 'package:quran/provider/app_localizations.dart';
import 'package:quran/screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   var prefs = await SharedPreferences.getInstance();
  runApp(
      ChangeNotifierProvider<AppLanguage>(create:(context)=> AppLanguage(),child: MyApp(),));
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (_) => ShopProvider()),
    //     ChangeNotifierProvider(create: (_) => AppLanguage()),
    //   ],
    //   child:  MyApp(
    //   ),
    // ),
 // );
}

class MyApp extends StatelessWidget {
   
  const MyApp({ super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     var appLanguage = Provider.of<AppLanguage>(context);
    return MaterialApp(
       supportedLocales: [
            Locale('ar', 'OM'),
            Locale('en', 'US'),  
          ],
            localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: appLanguage.appLocal,
      debugShowCheckedModeBanner: false,
      title: 'Holy Quran',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  SplashScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});



//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
// TextEditingController controller = TextEditingController();
// String name = "";
 
//   @override
//   Widget build(BuildContext context) {
  
//     return Scaffold(
//       appBar: AppBar(
        
//         title: Text("Day 3"),
//         centerTitle: true,
//         leading: Icon(Icons.home),
//         backgroundColor: Colors.amber,
//         foregroundColor: Colors.white,
//       ),
//       body: 
       
//      SingleChildScrollView(
//        child: Container(
//         height: MediaQuery.of(context).size.height,
//         width:  MediaQuery.of(context).size.width,
        
//          child: ListView.separated(
//           separatorBuilder: (BuildContext context, int index) => const Divider(),
//           itemBuilder: (BuildContext context, int index) { return  CardView(name: "Oamr", number: "1231",); },
//           itemCount: 10,
             
//          ),
//        ),
//      ),
      
//    // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
  

// }


// class CardView extends StatelessWidget {
//   var name;
  
//   var number;

//    CardView({this.name , this.number});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//   leading: Icon(Icons.call),    title: Text(name),
//       subtitle: Text(number),
      
//     );
//   }
// }

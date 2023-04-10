import 'package:flutter/material.dart';
import 'package:prcatice_1/api/services_all.dart';
import 'package:prcatice_1/model/quran_model.dart';
import 'package:prcatice_1/provider/AppLanguage.dart';
import 'package:prcatice_1/screen/details_page.dart';
import 'package:prcatice_1/util/constant.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 List<Surah?> surahs = [];
  ServiceApi api = ServiceApi();
  

@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: basic,
        title:   Text("المصحف الشريف")
      ),
      
      body: FutureBuilder<List<Surah>>(
      future:  api.getData(),
      builder: (BuildContext context , AsyncSnapshot<List> snapshot) {
      if(snapshot.hasData){
        return Row(
          children: [
            Expanded(child: Container(
              child: ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder:(BuildContext context ,int index){
                return Container(child:Card(
                  child: ListTile(
                  tileColor: Colors.grey[200],
                  title:Text(snapshot.data![index].name.toString())  ,
                  subtitle:Text(snapshot.data![index].englishName.toString()) ,
                  leading: CircleAvatar(child: Text(snapshot.data![index].number.toString()),backgroundColor: basic ,),
                  trailing: Icon(Icons.bookmark),
                   onTap: () =>  Navigator.of(context).push(MaterialPageRoute(builder: (_) => DetailScreen(surah:snapshot.data![index]))) ,
                  ),
                ));
              } )
            ))
          ],
        );
      }
      if(snapshot.hasError){
        print("error is >> ${snapshot.error}");
        return Center(child: Icon(Icons.error, color: Colors.red, size :80,),);
      }
      return Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20.0,),
          Text("يتم تحميل المصحف الرجاء الانتظار"),
        ],
      ),);
      }
    ));
  }
}


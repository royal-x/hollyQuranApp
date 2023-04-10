import "package:http/http.dart" as http;
import '../model/quran_model.dart';




class ServiceApi {

 Future<List<Surah>> getData() async{

  List<Surah> surahs = [];
 
var request = http.Request('GET', Uri.parse('http://api.alquran.cloud/v1/quran/ar.alafasy'));


http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  var result = await response.stream.bytesToString();
  var model =  quranApiFromMap(result);
  surahs = model.data!.surahs!;
}
else {
  print(response.reasonPhrase);
}
return surahs;
  }
}
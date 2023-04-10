import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:prcatice_1/model/quran_model.dart';
import 'package:prcatice_1/util/constant.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shimmer/shimmer.dart';



class DetailScreen extends StatefulWidget {
Surah? surah;
   DetailScreen({this.surah, super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<Ayah>?ayahs = [];
   AudioPlayer? player ; 
   
  bool isPlaying = false;
  ConcatenatingAudioSource? playlist ;

  bool isLoading = false;
   
Stream<PositionData> get _positionDataStream => 
Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
player!.positionStream,
player!.bufferedPositionStream, 
player!.durationStream,
(position, bufferPosition , duration) => PositionData(position, bufferPosition, duration ?? Duration.zero)
);



  @override
  void initState() {
   
   player = AudioPlayer();
   fetchAudio();
    // TODO: implement initState
    super.initState();
    // player!..setUrl("https://cdn.islamic.network/quran/audio/128/ar.alafasy/1.mp3");
  
  }

  Future<void> fetchAudio()async{
     ayahs = widget.surah!.ayahs!;
     playlist = ConcatenatingAudioSource(children: [
     for(var i in ayahs!)
    AudioSource.uri(Uri.parse(i.audio!),
    tag: Ayah(
      numberInSurah: i.numberInSurah,
      text: i.text,
    ))
   ]);
  //  await player!..setUrl("https://cdn.islamic.network/quran/audio/128/ar.alafasy/1.mp3");
 //  await player!.setLoopMode(LoopMode.all);
    await player!.setAudioSource(playlist!);
  }
  
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player!.dispose();
  }
 
     
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:  Color(0xFF144771),
        elevation: 0,
       
        title: Text("${widget.surah!.name}" , style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF144771) , Color(0xFF071A2C)]
        )),
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
    
StreamBuilder<SequenceState?>(
  stream: player!.sequenceStateStream,
  builder:  (context, snapshot) {
 
      isLoading = true;

    final state  = snapshot.data;
    if(state?.sequence.isEmpty ?? true){
       
      isLoading = false;
 
return SizedBox();

    }
          
      isLoading = false;
   
    final metadata = state!.currentSource!.tag as Ayah;
    return AyahMetaData(ayah: metadata.text.toString(), number: metadata.numberInSurah.toString());
      } ),
SizedBox(
  height: MediaQuery.of(context).size.height * 0.2,
  child:  isLoading ? Center(child: CircularProgressIndicator(),) : Column(
  
    children: [
  
        SizedBox(height: 20,),
  
          StreamBuilder<PositionData>(
  
            stream: _positionDataStream,
  
            builder: (context, snapshot){
  
              final positionData = snapshot.data;
  if(snapshot.hasData){
return ProgressBar(
  
                timeLabelTextStyle: TextStyle(color: Colors.white),
  
                progress: positionData!.position ,
  
              buffered: positionData.bufferPosition,
  
               total: positionData.duration,
  
               onSeek: player!.seek,);
  }else if(snapshot.hasError){
    return Center(child: Text("حدثت مشكلة في الاتصال"),);
  }
       return Center(child: CircularProgressIndicator(),);      
  
            }),
  
            const SizedBox(height: 20,),
  
           Controls(audioPlayer: player!)
  
         
  
    ],
  
  ),
),


          ],
        ),
    
        
        )
        
        
        );
        
  }
  
}

  class Controls extends StatelessWidget{
    const Controls({
      super.key,
      required this.audioPlayer,
    });

    final AudioPlayer audioPlayer;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Row(
    mainAxisAlignment: MainAxisAlignment.center,
     children: [
      IconButton(onPressed: audioPlayer.seekToPrevious,
      iconSize: 60,
      color: Colors.white,
       icon: Icon(Icons.skip_next_rounded)),
       StreamBuilder<PlayerState>(
        stream: audioPlayer.playerStateStream,
        builder: (context, snapshot) {
       final playerState = snapshot.data;
       final processingState = playerState?.processingState;
       final playing = playerState?.playing;
       if(!(playing ?? false)){
        return IconButton(onPressed: audioPlayer.play,
        iconSize: 80,
        color: Colors.white,
         icon: Icon(Icons.play_arrow_rounded));
       }else if(processingState != ProcessingState.completed){
        return  IconButton(onPressed: audioPlayer.pause,
        iconSize: 80,
        color: Colors.white,
         icon: Icon(Icons.pause_circle_rounded));
       }
       return  Icon(
        size: 80,
        color: Colors.white,
         Icons.play_arrow_rounded);
        } ),

          IconButton(onPressed: audioPlayer.seekToNext,
      iconSize: 60,
      color: Colors.white,
       icon: Icon(Icons.skip_previous_rounded)),
     ],
   );
  }

  }

  class PositionData{
  final Duration position;
  
  final Duration  bufferPosition;
  
  final Duration  duration;
  
    const PositionData(
      this.position,
      this.bufferPosition,
      this.duration
    );
  }

  class AyahMetaData extends StatelessWidget {
  String ayah;
  String number;
  
    AyahMetaData({
super.key, 
required this.ayah,
required this.number,
    });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Column(
    children: [
DecoratedBox(
  decoration: BoxDecoration(
  boxShadow: const[
    BoxShadow(
    color: Colors.white,
    offset: Offset(2,4),
    blurRadius: 4,
  )
  ],
  borderRadius: BorderRadius.circular(10),
  ),
child: ClipRRect(borderRadius: BorderRadius.circular(10),
child: SizedBox(
  height: MediaQuery.of(context).size.height * 0.6,
  child:   Column(
  crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
  
    children: [
         
          Expanded(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child:
         Shimmer.fromColors(
           baseColor:Color.fromARGB(255, 108, 108, 108) , 
           highlightColor: Color(0xFF071A2C),
           child: SingleChildScrollView(
             child: Text(
               ayah.replaceAll('بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ', 'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ' + "\n"),
               textAlign: TextAlign.center,
               style: TextStyle(
                 fontSize: 20.0,
                 fontWeight:
                 FontWeight.bold,
               ),
             ),
           ),
         )
            
            
            
            
            
            //  Text(ayah, style: TextStyle(fontSize: 30, color: Colors.black),textAlign: TextAlign.center,)
             ),
          )),
  
          
  
  CircleAvatar(child: Text(number) , backgroundColor: basic, radius: 20,),
   Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/sound.gif", width: 60 , height: 40,),
          ),
    ],
  
  ),
),),
),

   ]);
  }

  }


  
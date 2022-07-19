import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'musique.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:audioplayer/audioplayer.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Woyalma',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Woyalma'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  List<Musique> maListeDeMusique = [
      Musique('Dictature 1', 'Omzo Dollar', 'assets/omzo3.jpg',
        'https://www.boomplay.com/songs/45283253?from=search'),
    Musique('Girls want girls', 'Drake ft Lil Baby', 'assets/drake2.jpg',
        'https://www.boomplay.com/songs/3406894?from=search'),
  
  ];
late Musique maMusiqueActuelle;
Duration position = Duration(seconds: 0);
Duration duree = Duration(seconds: 10);
late AudioPlayer audioPlayer;
late StreamSubscription positionSub;
late StreamSubscription stateSubscription;
PlayerState statut = PlayerState.stopped;


  void initState() {
    super.initState();
    maMusiqueActuelle = maListeDeMusique[0];
    configurationAudioPlayer();
    log(maMusiqueActuelle.titre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(widget.title)),
       backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Card(
              elevation: 9.0,
              child: Container(
                width: MediaQuery.of(context).size.height / 2.5,
                child: Image.asset(maMusiqueActuelle.imagePath),
              ),
            ),
            textAvecStyle(maMusiqueActuelle.titre, 1.5),
            textAvecStyle(maMusiqueActuelle.artiste, 1.0),
            new Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buton(Icons.fast_rewind, 30.0, actionMusic.rewind),
                buton(Icons.play_arrow, 45.0, actionMusic.play),
                buton(Icons.fast_forward, 30.0, actionMusic.forward),
              ],
            ),
            new Row (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                textAvecStyle('0:0', 0.8),
                textAvecStyle('3:45', 0.8),
              ],
            ),
            new Slider(
              value: position.inSeconds.toDouble(),
              min: 0.0,
              max : 30.0, 
              inactiveColor: Colors.white,
              activeColor: Colors.red,
              onChanged:(double d){
                setState(() {
                  Duration newDuration =  Duration(seconds: d.toInt());
                  position= newDuration;
                });
              }
              )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
IconButton buton(IconData icone, double taille, actionMusic action){
  return new IconButton( 
    iconSize: taille,
    color: Colors.white,
    icon: Icon(icone),
    onPressed: () {
      switch (action){
        case actionMusic.play:
         print(('Play'));
         break;
          case actionMusic.pause:
         print(('Pause'));
         break;
          case actionMusic.forward:
         print(('Forward'));
         break;
          case actionMusic.rewind:
         print(('Rewind'));
         break;
      }
    },
);
}

  Text textAvecStyle(String data, double scale) {
    return new Text(
      data,
      textScaleFactor: scale,
      textAlign: TextAlign.center,
      style: new TextStyle(
          color: Colors.white, fontSize: 20.0, fontStyle: FontStyle.italic),
    );
  }
  void configurationAudioPlayer(){
    audioPlayer= AudioPlayer();
    positionSub = audioPlayer.onAudioPositionChanged.listen(
      (pos) => setState(() => position = pos));
      stateSubscription = audioPlayer.onPlayerStateChanged.listen((state) { 
        if (state == AudioPlayerState.PLAYING) {
          setState(() {
            duree  = audioPlayer.duration;
          });
        } else if(state == AudioPlayerState.STOPPED){
          setState(() {
            statut = PlayerState.stopped;
          });
        }
      },onError: (message) {
        print('erreur : $message');
        setState(() {
          statut = PlayerState.stopped;
          duree = Duration (seconds: 0);
          position = Duration (seconds: 0);
        });
      }
      );
  }
 
}
 enum actionMusic{
  play,
  pause,
  rewind,
  forward
  }
  
  enum PlayerState{
    playing,
    stopped,
    paused
  }
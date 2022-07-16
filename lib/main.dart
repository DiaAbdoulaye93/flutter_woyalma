import 'package:flutter/material.dart';
import 'musique.dart';

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
    new Musique('Theme Swift', 'Drizy', 'assets/drake2.jpeg',
        'https://www.boomplay.com/songs/3406894?from=search'),
    new Musique('Theme Flutter', 'Omzo Dollar', 'assets/omzo3.jpeg',
        'https://www.boomplay.com/songs/45283253?from=search')
  ];
  late Musique maMusiqueActuelle;
  @override
  void initSate() {
    super.initState();
    maMusiqueActuelle = maListeDeMusique[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Card (
              elevation: 9.0,
              child: Container(
                width: MediaQuery.of(context).size.height/2.5,
                child: Image.asset(maMusiqueActuelle.imagePath),
              ),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

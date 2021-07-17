import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:location/location.dart';
import 'package:mariocart/controllers/controller.dart';
import 'package:mariocart/page/maps.dart';
import 'package:mariocart/page/registrate.dart';
import 'package:mariocart/page/sign.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
// Elsewhere in your code
  //  FirebaseCrashlytics.instance.crash();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Location location = new Location();
  LocationData _currentPosition;
  PermissionStatus _permissionGranted;

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context) /*!*/ .push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLoc();
  }
final MyController  controller = Get.put(MyController());
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(children: [
          
          Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.45),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child: SignInButtonBuilder(
                  icon: Icons.person_add,
                  backgroundColor: Colors.indigo,
                  text: 'Registration',
                  onPressed: (){
                    _pushPage(context, RegisterPage());
                    print('object');
                    }
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child: SignInButtonBuilder(
                  icon: Icons.verified_user,
                  backgroundColor: Colors.orange,
                  text: 'Sign In',
                  onPressed: () => _pushPage(context, SignInPage()),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child: SignInButtonBuilder(
                    icon: Icons.verified_user,
                    backgroundColor: Colors.green,
                    text: 'Google Maps',
                    onPressed: () => _pushPage(context, MyApp2())),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child: SignInButtonBuilder(
                  icon: Icons.verified_user,
                  backgroundColor: Colors.red,
                  text: 'Maps requirerments',
                  onPressed: _getLoc,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                child: SignInButtonBuilder(
                  icon: Icons.verified_user,
                  backgroundColor: Colors.red,
                  text: 'Firebase crashlylics',
                  onPressed: () {
                    FirebaseCrashlytics.instance.crash();
                  },
                ),
              ),
            ],
          
          
                  ),
          ),
        
        GetX<MyController>(
           initState:(state){
             Future.delayed(Duration(seconds: 4), () {
  // 5s over, navigate to a new page
 controller.posicaoDaLogo();
});

              },
              builder: (_)=> 
                 AnimatedPositioned(
                           
              
                           duration: Duration(seconds: 2),
                           top: _.bottom.toDouble(),
                           
              
              
                        child:   Container(
                        child: Center(child: Image.asset('mario.png'),),
              
              
                       )
                          ),
              ),
               GetX<MyController>(
           initState:(state){
             Future.delayed(Duration(seconds: 4), () {
  // 5s over, navigate to a new page
 controller.posicaoDaLogo2();
});

              },
              builder: (_)=> 
                 AnimatedPositioned(
                           
              
                           duration: Duration(seconds: 2),
                           right: _.left.toDouble(),
                           
              
              
                        child:   Container(
                          width: 800,
                          height: 800,
                        child: Center(child: Image.asset('mario2.png'),),
              
              
                       )
                          ),
              ),
      
      
        
        ],),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // retorna um objeto do tipo Dialog
          return AlertDialog(
            title: new Text("Considere map reuired"),
            content: new Text("mapa presisa da sua permissão "),
            actions: <Widget>[
              // define os botões na base do dialogo
              new FlatButton(
                child: new Text("Fechar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }
}

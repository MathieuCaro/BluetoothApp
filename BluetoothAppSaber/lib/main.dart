import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'FindDevicesScreen.dart';
import './BluetoothOff.dart';
//import './ParametersScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //Couleur du thème
          primaryColor: Colors.blue[700],
          brightness: Brightness.dark,
          //Couleur de l'écriture
          fontFamily: 'Roboto',
        ),
        home: StreamBuilder<BluetoothState>(
            stream: FlutterBlue.instance.state,
            initialData: BluetoothState.unknown, //etat du bluetooth initial
            builder: (c, snapshot) {
              final state = snapshot.data; // state=etat du Bluetooth
              // Voir si le Bluetooth est activé
              if (state == BluetoothState.on) {
                //return Parameters();
                return MyHomePage(title: 'BT Application Sabre');
                //return MyHomePage(title: 'Sabre App');
              }
              return BluetoothOffScreen(state: state);
            }),
      );
}

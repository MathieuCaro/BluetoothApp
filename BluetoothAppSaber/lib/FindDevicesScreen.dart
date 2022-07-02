import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import './ParametersScreen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList = []; //liste des devices
  final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();

  //final ButtonTheme boutons= ;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final _writeController = TextEditingController(); //création d'une boite texte
  BluetoothDevice _connectedDevice;
  List<BluetoothService> _services;
  Color color = Colors.blue;

  _addDeviceTolist(final BluetoothDevice device) {
    if (!widget.devicesList.contains(device)) {
      setState(() {
        if (device.name != '') {
          //enlever les devices qui ne sont pas "valides"
          widget.devicesList.add(device); //ajouter les devices à la liste
        }
      });
    }
  }

//Affichage de la liste des périphériques bluetooth

  @override
  void initState() {
    super.initState();
    widget.flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceTolist(result.device);
      }
    });
    widget.flutterBlue.startScan();
  }

  ListView _buildListViewOfDevices() {
    List<Container> containers = [];
    for (BluetoothDevice device in widget.devicesList) {
      containers.add(
        Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(device.name == ''
                        ? 'périphérique inconnu'
                        : device.name),
                    Text(device.id.toString()),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: Text(
                  'Connect',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  widget.flutterBlue
                      .stopScan(); //stopper le scan si appairage réalisé
                  try {
                    await device.connect();
                  } catch (e) {
                    if (e.code != 'déja connecté') {
                      throw e;
                    }
                  } finally {
                    _services = await device.discoverServices();
                  }
                  setState(() {
                    _connectedDevice = device;
                  });
                },
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

// Lecture/Ecriture/Notify de Characteristics

  List<ButtonTheme> _couleurdusabre1(BluetoothCharacteristic characteristic) {
    List<ButtonTheme> buttons = [];
    /*List<String> fonction = [
      'couleurdusabre1',
      'couleurduchoc1',
      'couleurduchoc2'
    ];*/
    List<Color> color1 = [
      Colors.yellow[100],
      Colors.yellow,
      Colors.orange,
      Colors.red,
    ];

    //Color color = Colors.blue;

    //Ecriture de characteristic
    if (characteristic.properties.write) {
      for (Color couleur in color1) {
        buttons.add(
          ButtonTheme(
            minWidth: 10,
            height: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                child: Text(''),
                style: ElevatedButton.styleFrom(
                    primary: couleur,
                    fixedSize: Size(20, 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  //Color couleur = Colors.blueAccent;
                  List<int> tramesabre =
                      trame('write', 'couleurdusabre', 'couleur', couleur);
                  print(tramesabre);
                  characteristic.write(tramesabre);
                },
              ),
            ),
          ),
        );
      }
    }
    return buttons;
  }

  List<ButtonTheme> _couleurdusabre2(BluetoothCharacteristic characteristic) {
    List<ButtonTheme> buttons = [];
    List<Color> color2 = [
      Colors.white,
      Colors.pink[200],
      Colors.purpleAccent,
      Colors.deepPurpleAccent
    ];
    for (Color couleur in color2) {
      buttons.add(
        ButtonTheme(
          minWidth: 10,
          height: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              child: Text(''),
              style: ElevatedButton.styleFrom(
                  primary: couleur,
                  fixedSize: Size(20, 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              onPressed: () {
                //Color couleur = Colors.blueAccent;
                List<int> tramesabre =
                    trame('write', 'couleurdusabre', 'couleur', couleur);
                print(tramesabre);
                characteristic.write(tramesabre);
              },
            ),
          ),
        ),
      );
    }
    return buttons;
  }

  List<ButtonTheme> _couleurdusabre3(BluetoothCharacteristic characteristic) {
    List<ButtonTheme> buttons = [];
    List<Color> color3 = [
      Colors.green[900],
      Colors.greenAccent,
      Colors.cyan,
      Colors.blue,
    ];

    //Ecriture de characteristic
    if (characteristic.properties.write) {
      for (Color couleur in color3) {
        buttons.add(
          ButtonTheme(
            minWidth: 10,
            height: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                child: Text(''),
                style: ElevatedButton.styleFrom(
                    primary: couleur,
                    fixedSize: Size(20, 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  List<int> tramesabre =
                      trame('write', 'couleurdusabre', 'couleur', couleur);
                  print(tramesabre);
                  characteristic.write(tramesabre);
                },
              ),
            ),
          ),
        );
      }
    }
    return buttons;
  }

  List<ButtonTheme> _premierecouleurduchoc1(
      BluetoothCharacteristic characteristic) {
    List<ButtonTheme> buttons = [];
    List<Color> color1 = [
      Colors.yellow[100],
      Colors.yellow,
      Colors.orange,
      Colors.red,
    ];
    for (Color couleur in color1) {
      //Ecriture de characteristic
      if (characteristic.properties.write) {
        buttons.add(
          ButtonTheme(
            minWidth: 10,
            height: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                child: Text(''),
                style: ElevatedButton.styleFrom(
                    primary: couleur,
                    fixedSize: Size(20, 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  List<int> tramesabre =
                      trame('write', 'couleurduchoc1', 'couleur', couleur);
                  print(tramesabre);
                  characteristic.write(tramesabre);
                },
              ),
            ),
          ),
        );
      }
    }
    return buttons;
  }

  List<ButtonTheme> _premierecouleurduchoc2(
      BluetoothCharacteristic characteristic) {
    List<ButtonTheme> buttons = [];
    List<Color> color2 = [
      Colors.white,
      Colors.pink[200],
      Colors.purpleAccent,
      Colors.deepPurpleAccent
    ];

    //Ecriture de characteristic
    if (characteristic.properties.write) {
      for (Color couleur in color2) {
        buttons.add(
          ButtonTheme(
            minWidth: 10,
            height: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                child: Text(''),
                style: ElevatedButton.styleFrom(
                    primary: couleur,
                    fixedSize: Size(20, 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  List<int> tramesabre =
                      trame('write', 'couleurduchoc1', 'couleur', couleur);
                  print(tramesabre);
                  characteristic.write(tramesabre);
                },
              ),
            ),
          ),
        );
      }
    }
    return buttons;
  }

  List<ButtonTheme> _premierecouleurduchoc3(
      BluetoothCharacteristic characteristic) {
    List<ButtonTheme> buttons = [];
    List<Color> color3 = [
      Colors.green[900],
      Colors.greenAccent,
      Colors.cyan,
      Colors.blue,
    ];
    for (Color couleur in color3) {
      //Ecriture de characteristic
      if (characteristic.properties.write) {
        buttons.add(
          ButtonTheme(
            minWidth: 10,
            height: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                child: Text(''),
                style: ElevatedButton.styleFrom(
                    primary: couleur,
                    fixedSize: Size(20, 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  List<int> tramesabre =
                      trame('write', 'couleurduchoc1', 'couleur', couleur);
                  print(tramesabre);
                  characteristic.write(tramesabre);
                },
              ),
            ),
          ),
        );
      }
    }
    return buttons;
  }

  List<ButtonTheme> _secondecouleurduchoc1(
      BluetoothCharacteristic characteristic) {
    List<ButtonTheme> buttons = [];
    List<Color> color1 = [
      Colors.yellow[100],
      Colors.yellow,
      Colors.orange,
      Colors.red,
    ];
    for (Color couleur in color1) {
      //Ecriture de characteristic
      if (characteristic.properties.write) {
        buttons.add(
          ButtonTheme(
            minWidth: 10,
            height: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                child: Text(''),
                style: ElevatedButton.styleFrom(
                    primary: couleur,
                    fixedSize: Size(20, 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  List<int> tramesabre =
                      trame('write', 'couleurduchoc2', 'couleur', couleur);
                  print(tramesabre);
                  characteristic.write(tramesabre);
                },
              ),
            ),
          ),
        );
      }
    }
    return buttons;
  }

  List<ButtonTheme> _secondecouleurduchoc2(
      BluetoothCharacteristic characteristic) {
    List<ButtonTheme> buttons = [];
    List<Color> color2 = [
      Colors.white,
      Colors.pink[200],
      Colors.purpleAccent,
      Colors.deepPurpleAccent
    ];
    for (Color couleur in color2) {
      //Ecriture de characteristic
      if (characteristic.properties.write) {
        buttons.add(
          ButtonTheme(
            minWidth: 10,
            height: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                child: Text(''),
                style: ElevatedButton.styleFrom(
                    primary: couleur,
                    fixedSize: Size(20, 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  List<int> tramesabre =
                      trame('write', 'couleurduchoc2', 'couleur', couleur);
                  print(tramesabre);
                  characteristic.write(tramesabre);
                },
              ),
            ),
          ),
        );
      }
    }
    return buttons;
  }

  List<ButtonTheme> _secondecouleurduchoc3(
      BluetoothCharacteristic characteristic) {
    List<ButtonTheme> buttons = [];
    List<Color> color3 = [
      Colors.green[900],
      Colors.greenAccent,
      Colors.cyan,
      Colors.blue,
    ];
    for (Color couleur in color3) {
      //Ecriture de characteristic
      if (characteristic.properties.write) {
        buttons.add(
          ButtonTheme(
            minWidth: 10,
            height: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                child: Text(''),
                style: ElevatedButton.styleFrom(
                    primary: couleur,
                    fixedSize: Size(20, 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  List<int> tramesabre =
                      trame('write', 'couleurduchoc1', 'couleur', couleur);
                  print(tramesabre);
                  characteristic.write(tramesabre);
                },
              ),
            ),
          ),
        );
      }
    }
    return buttons;
  }

  ListView _buildConnectDeviceView() {
    List<Container> containers = [];

    for (BluetoothService service in _services) {
      //List<Widget> premierecouleurdublaster = [];
      List<Widget> couleurdusabre = [];
      List<Widget> premierecouleurduchoc = [];
      List<Widget> secondecouleurduchoc = [];

      //double _sliderValue = 20;

      if (service.uuid.toString() == 'bc2f4cc6-aaef-4351-9034-d66268e328f0') {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.uuid.toString() ==
              '06d1e5e7-79ad-4a71-8faa-373789f7d93c') {
            print(characteristic.uuid.toString());
            couleurdusabre.add(
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ..._couleurdusabre1(characteristic),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        ..._couleurdusabre2(characteristic),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        ..._couleurdusabre3(characteristic),
                      ],
                    ),
                    Divider(color: Colors.red),
                  ],
                ),
              ),
            );
            premierecouleurduchoc.add(
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ..._premierecouleurduchoc1(characteristic),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        ..._premierecouleurduchoc2(characteristic),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        ..._premierecouleurduchoc3(characteristic),
                      ],
                    ),
                    Divider(color: Colors.yellow),
                  ],
                ),
              ),
            );
            secondecouleurduchoc.add(
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ..._secondecouleurduchoc1(characteristic),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        ..._secondecouleurduchoc2(characteristic),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        ..._secondecouleurduchoc3(characteristic),
                      ],
                    ),
                    Divider(color: Colors.yellow),
                  ],
                ),
              ),
            );
          }
        }
      }
      if (service.uuid.toString() == 'bc2f4cc6-aaef-4351-9034-d66268e328f0') {
        containers.add(Container(
          child: Text('Couleurs :',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
        ));
        containers.add(Container(
            child: Expanded(
          child: new Container(
              margin: const EdgeInsets.only(left: 15.0, right: 10.0),
              child: Divider(
                thickness: 1,
                color: Colors.red,
                height: 20,
              )),
        )));
        containers.add(
          Container(
            child: ExpansionTile(
                title: Text('Couleur du sabre'),
                textColor: Colors.white,
                children: couleurdusabre),
          ),
        );
        containers.add(
          Container(
            child: ExpansionTile(
                title: Text('Première couleur du choc'),
                textColor: Colors.white,
                children: premierecouleurduchoc),
          ),
        );
        containers.add(
          Container(
            child: ExpansionTile(
                title: Text('Seconde couleur du choc'),
                textColor: Colors.white,
                children: secondecouleurduchoc),
          ),
        );
        containers.add(Container(
          child: Text('Son :',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
        ));
        containers.add(Container(
            child: Expanded(
          child: new Container(
              margin: const EdgeInsets.only(left: 15.0, right: 10.0),
              child: Divider(
                thickness: 1,
                color: Colors.red,
                height: 20,
              )),
        )));
        containers.add(Container(
          child: Text('Volume :',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15)),
        ));
        containers.add(
          Container(),
        );
      }
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  ListView _buildView() {
    if (_connectedDevice != null) {
      return _buildConnectDeviceView();
    }
    return _buildListViewOfDevices();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _buildView(),
      );
}

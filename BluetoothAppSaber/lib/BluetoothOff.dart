import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key key, this.state}) : super(key: key);
  final BluetoothState state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 350.0,
              color: Colors.blue[900],
            ),
            Text(
              'Bluetooth est désactivé',
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 25,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}

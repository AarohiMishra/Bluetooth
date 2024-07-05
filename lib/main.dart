/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:bluetooth/ble_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bluetooth Scanner',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final BleController bleController = Get.put(BleController()); // Get instance of BleController

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bluetooth Scanner')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<BleController>(
              init: bleController,
              builder: (controller) {
                return StreamBuilder<List<ScanResult>>(
                  stream: controller.scanResults,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return CircularProgressIndicator();
                      case ConnectionState.active:
                        if (snapshot.hasData) {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final data = snapshot.data![index];
                                return Card(
                                  elevation: 2,
                                  child: ListTile(
                                    title: Text(data.device.name ?? 'Unknown'),
                                    subtitle: Text(data.device.id.id),
                                    trailing: Text(data.rssi.toString()),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(child: Text("No Devices found"));
                        }
                      default:
                        return Text('Connection State: ${snapshot.connectionState}');
                    }
                  },
                );
              },

            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                bleController.startScanDevices(); // Start scanning
              },
              child: Text('Scan'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                bleController.stopScanDevices(); // Stop scanning
              },
              child: Text('Stop Scan'),
            ),
          ],
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:all_bluetooth/all_bluetooth.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BluetoothScreen(),
    );
  }
}

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _connectedDevice;

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  Future<void> _initBluetooth() async {
    bool? isOn = await Bluetooth.isOn;
    if (isOn == true) {
      _startScan();
    } else {
      // Handle the case when Bluetooth is off
    }
  }

  void _startScan() async {
    Bluetooth.scan().listen((device) {
      setState(() {
        _devices.add(device);
      });
    });
  }

  void _connect(BluetoothDevice device) async {
    bool isConnected = await device.connect();
    if (isConnected) {
      setState(() {
        _connectedDevice = device;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bluetooth')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _startScan,
            child: Text('Scan for Devices'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                BluetoothDevice device = _devices[index];
                return ListTile(
                  title: Text(device.name ?? 'Unknown Device'),
                  subtitle: Text(device.address),
                  onTap: () => _connect(device),
                );
              },
            ),
          ),
          if (_connectedDevice != null)
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Connected to ${_connectedDevice!.name}'),
            ),
        ],
      ),
    );
  }
}

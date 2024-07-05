/*import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BleController extends GetxController {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  bool isScanning = false;

  Future<void> startScanDevices() async {
    if (isScanning) {
      print('Already scanning');
      return;
    }

    var status = await Permission.bluetoothScan.status;
    if (!status.isGranted) {
      status = await Permission.bluetoothScan.request();
      if (!status.isGranted) {
        print('Bluetooth scan permission denied');
        return;
      }
    }

    status = await Permission.bluetoothConnect.status;
    if (!status.isGranted) {
      status = await Permission.bluetoothConnect.request();
      if (!status.isGranted) {
        print('Bluetooth connect permission denied');
        return;
      }
    }

    try {
      isScanning = true;
      flutterBlue.startScan(timeout: Duration(seconds: 15));
    } catch (e) {
      print('Error starting scan: $e');
      isScanning = false; // Reset scanning state on error
    }
  }

  void stopScanDevices() {
    if (isScanning) {
      flutterBlue.stopScan();
      isScanning = false;
    }
  }

  Stream<List<ScanResult>> get scanResults => flutterBlue.scanResults;
}
*/

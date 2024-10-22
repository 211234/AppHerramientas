import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  @override
  _QrScannerScreenState createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  String? scannedData;
  bool isCameraWorking = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escáner de QR'),
        actions: [
          IconButton(
            icon: Icon(isCameraWorking ? Icons.camera_alt : Icons.visibility_off),
            onPressed: () {
              setState(() {
                isCameraWorking = !isCameraWorking;
              });
            },
          )
        ],
      ),
      body: isCameraWorking
          ? Column(
        children: [
          Expanded(
            flex: 4,
            child: MobileScanner(
              onDetect: (BarcodeCapture capture) {
                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                  final String code = barcodes.first.rawValue ?? 'Código QR no válido';
                  setState(() {
                    scannedData = code;
                  });
                  _showScannedDataDialog(context, code);
                }
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: scannedData != null
                  ? Text(
                'Código QR Escaneado: $scannedData',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              )
                  : Text(
                'Escanea un código QR apuntando la cámara',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      )
          : Center(
        child: Text('La cámara está apagada. Actívala desde el ícono en la barra superior.'),
      ),
    );
  }

  // Mostrar el diálogo con los datos del código escaneado
  void _showScannedDataDialog(BuildContext context, String code) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Código QR Escaneado'),
          content: Text('Contenido: $code'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}

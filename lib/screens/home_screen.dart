import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'geolocator_screen.dart';
import 'qr_scanner_screen.dart';
import 'sensorplus_screen.dart';
import 'speech_to_text_screen.dart';
import 'text_to_speech_screen.dart';

class HomeScreen extends StatelessWidget {
  final String githubUrl = 'https://github.com/211234/AppHerramientas.git';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.link),
              title: Text('Repositorio'),
              onTap: () async {
                if (await canLaunch(githubUrl)) {
                  await launch(githubUrl);
                } else {
                  throw 'No se pudo abrir $githubUrl';
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Geolocator'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GeolocatorScreen()), // Navegar a la pantalla de Geolocator
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.qr_code),
              title: Text('Qrflutter'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QrScannerScreen()), // Navegar a la pantalla QRScanner
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.sensors),
              title: Text('Sensorplus'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SensorPlusScreen()), // Navegar a la pantalla de Sensorplus
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.mic),
              title: Text('Speech to Text'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SpeechToTextScreen()),  // Navegar a la pantalla de Speech to Text
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.volume_up),
              title: Text('Text to Speech'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TextToSpeechScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/LogoUp.jpeg', // Asegúrate de agregar el logo en la carpeta assets
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              'Universidad: UP Chiapas',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Carrera: Ingeniería en Software',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Materia: Programación para Móviles II',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Grupo: A',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Alumno: César Josué Martínez Castillejos',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Matrícula: 211234',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

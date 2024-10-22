import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';  // Importamos para abrir Google Maps

class GeolocatorScreen extends StatefulWidget {
  @override
  _GeolocatorScreenState createState() => _GeolocatorScreenState();
}

class _GeolocatorScreenState extends State<GeolocatorScreen> {
  String _locationMessage = "Presiona el botón para obtener tu ubicación";
  Position? _currentPosition;

  // Función para obtener la ubicación
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si el servicio de GPS está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = 'El servicio de ubicación está deshabilitado';
      });
      return;
    }

    // Verificar los permisos de ubicación
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = 'Los permisos de ubicación fueron denegados';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = 'Los permisos de ubicación fueron denegados permanentemente';
      });
      return;
    }

    // Obtener la posición actual
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;
      _locationMessage =
      'Latitud: ${position.latitude}, Longitud: ${position.longitude}';
    });
  }

  // Función para abrir Google Maps con las coordenadas actuales
  Future<void> _openInGoogleMaps() async {
    if (_currentPosition != null) {
      final latitude = _currentPosition!.latitude;
      final longitude = _currentPosition!.longitude;
      final googleMapsUrl =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

      if (await canLaunch(googleMapsUrl)) {
        await launch(googleMapsUrl);
      } else {
        throw 'No se pudo abrir Google Maps';
      }
    } else {
      setState(() {
        _locationMessage = 'Obtén la ubicación primero';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geolocator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _locationMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: Text('Obtener ubicación'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openInGoogleMaps,
              child: Text('Abrir en Google Maps'),
            ),
          ],
        ),
      ),
    );
  }
}

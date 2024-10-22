import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechScreen extends StatefulWidget {
  @override
  _TextToSpeechScreenState createState() => _TextToSpeechScreenState();
}

class _TextToSpeechScreenState extends State<TextToSpeechScreen> {
  FlutterTts _flutterTts = FlutterTts();
  String _text = ""; // Texto a reproducir

  Future<void> _speak() async {
    if (_text.isNotEmpty) {
      await _flutterTts.setLanguage("es-ES"); // Establece el idioma
      await _flutterTts.setPitch(1.0); // Establece el tono
      await _flutterTts.speak(_text); // Reproduce el texto
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text to Speech'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _text = value; // Actualiza el texto al escribir
                });
              },
              decoration: InputDecoration(
                labelText: 'Ingresa el texto a reproducir',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _speak,
              child: Text('Reproducir'),
            ),
          ],
        ),
      ),
    );
  }
}

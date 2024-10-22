import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextScreen extends StatefulWidget {
  @override
  _SpeechToTextScreenState createState() => _SpeechToTextScreenState();
}

class _SpeechToTextScreenState extends State<SpeechToTextScreen> {
  stt.SpeechToText? _speech; // Cambia a tipo anulable
  bool _isListening = false;
  String _text = "";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (_isListening) {
      await _speech?.stop(); // Detener la escucha
      setState(() {
        _isListening = false; // Cambia el estado de escucha
      });
    } else {
      bool available = await _speech?.initialize() ?? false; // Inicializa el reconocimiento
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech?.listen(onResult: (result) {
          setState(() {
            _text = result.recognizedWords; // Actualiza el texto reconocido
          });
        });
      }
    }
  }

  void _restart() {
    setState(() {
      _text = ""; // Reinicia el texto
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech to Text'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Texto Reconocido:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              _text,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _listen,
              child: Text(_isListening ? 'Detener' : 'Escuchar'),
            ),
            SizedBox(height: 20),
            if (!_isListening && _text.isNotEmpty) // Muestra el botón de reinicio solo si no se está escuchando y hay texto
              ElevatedButton(
                onPressed: _restart,
                child: Text('Reiniciar'),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_isListening) {
      _speech?.stop(); // Detener el reconocimiento si está escuchando
    }
    super.dispose();
  }
}

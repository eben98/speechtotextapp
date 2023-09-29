import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  /*
  * Variables for speech
  */
  SpeechToText _speechToText = SpeechToText();
  bool _isSpeechEnabled = false;
  String _lastSpokenWords = '';

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    _isSpeechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void startListening() async {
    await _speechToText.listen(onResult: speechResult);
    setState(() {});
  }

  void stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void speechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastSpokenWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            _speechToText.isListening ?
            '$_lastSpokenWords' 
            : _isSpeechEnabled ?
            'Tap to start' 
            : 'Speech not available'
          ),
          InkWell(
            onTap: _speechToText.isNotListening ? startListening : stopListening,
            child: Icon(
              _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
            ),
          )
        ],
      ),
    );
  }
}

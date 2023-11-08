// Import necessary packages
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyRecordingScreen(),
    );
  }
}

class MyRecordingScreen extends StatefulWidget {
  const MyRecordingScreen({super.key});

  @override
  _MyRecordingScreenState createState() => _MyRecordingScreenState();
}

class _MyRecordingScreenState extends State<MyRecordingScreen> {
  bool isRecording = false;

  // Start recording and enable screen wakelock
  void startRecording() {
    setState(() {
      isRecording = true;
    });
    Wakelock.enable();
    // Start your recording logic here
  }

  // Stop recording and disable screen wakelock
  void stopRecording() {
    setState(() {
      isRecording = false;
    });
    Wakelock.disable();
    // Stop your recording logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recording Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              isRecording ? 'Recording...' : 'Not Recording',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isRecording ? stopRecording : startRecording,
              child: Text(isRecording ? 'Stop Recording' : 'Start Recording'),
            ),
          ],
        ),
      ),
    );
  }
}

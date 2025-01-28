// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

/// A mixin that provides platform-specific (mobile/desktop) audio recording functionality.
/// Uses the `record` package for audio recording and the `path_provider` package to manage file paths.
mixin AudioRecorderMixin {
  /// Starts recording audio and saves it to a file at a platform-specific path.
  Future<void> recordFile(AudioRecorder recorder, RecordConfig config) async {
    final path = await _getPath(); // Generates a file path for the recording.
    await recorder.start(config, path: path);
  }

  /// Starts audio recording and handles the audio data stream.
  /// Captures streamed audio and writes it to a file incrementally.
  Future<void> recordStream(AudioRecorder recorder, RecordConfig config) async {
    final path = await _getPath(); // Generates a file path for the recording.

    final file = File(path); // Creates a file to write the streamed data.

    final stream = await recorder.startStream(config);

    stream.listen(
      // Processes the incoming audio data and appends it to the file.
      (data) {
        print(
          recorder.convertBytesToInt16(Uint8List.fromList(data)), // Converts audio data to Int16.
        );
        file.writeAsBytesSync(data, mode: FileMode.append); // Appends data to the file.
      },
      // Logs the completion of the recording stream.
      onDone: () {
        print('End of stream. File written to $path.');
      },
    );
  }

  /// This method is a no-op on non-web platforms.
  /// Web-specific functionality is implemented in `audio_recorder_web.dart`.
  void downloadWebData(String path) {}

  /// Generates a unique file path for saving audio recordings.
  Future<String> _getPath() async {
    final dir = await getApplicationDocumentsDirectory(); // Platform-specific documents directory.
    return p.join(
      dir.path,
      'audio_${DateTime.now().millisecondsSinceEpoch}.m4a', // Generates a timestamp-based file name.
    );
  }
}

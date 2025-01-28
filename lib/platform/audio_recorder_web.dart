import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart' as web;

import 'package:record/record.dart';

/// A mixin that provides web-specific audio recording functionality.
/// Uses the `record` package for audio recording and integrates with web APIs
/// to handle file downloads and streaming.
mixin AudioRecorderMixin {
  /// Starts recording audio and saves it to a file.
  /// Since web doesn't support file paths like mobile/desktop, the `path` is unused here.
  Future<void> recordFile(AudioRecorder recorder, RecordConfig config) {
    return recorder.start(config, path: '');
  }

  /// Starts audio recording and handles the audio data stream.
  /// Captures streamed audio, stores it in memory (`bytes`), and generates a downloadable file.
  Future<void> recordStream(AudioRecorder recorder, RecordConfig config) async {
    final bytes = <int>[]; // Buffer to store incoming audio data as bytes.
    final stream = await recorder.startStream(config);

    stream.listen(
      // Adds chunks of audio data to the `bytes` buffer.
      (data) => bytes.addAll(data),
      // Once the stream is finished, converts the `bytes` buffer into a downloadable web file.
      onDone: () => downloadWebData(
        web.URL.createObjectURL(
          web.Blob(<JSUint8Array>[Uint8List.fromList(bytes).toJS].toJS),
        ),
      ),
    );
  }

  /// Downloads the audio data as a `.wav` file on the web.
  /// Creates a hidden `<a>` element to trigger the browser's download functionality.
  void downloadWebData(String path) {
    final anchor = web.document.createElement('a') as web.HTMLAnchorElement
      ..href = path
      ..style.display = 'none'
      ..download = 'audio.wav'; // Downloads the file as "audio.wav".
    web.document.body!.appendChild(anchor);
    anchor.click(); // Programmatically triggers the download.
    web.document.body!.removeChild(anchor); // Cleans up the DOM.
  }
}

import 'dart:developer';
import 'package:file_picker/file_picker.dart';

Future<String?> pickImage() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      return result.files.single.path;
    }
  } catch (e) {
    log("Couldn't pick file: $e");
  }
  return null;
}

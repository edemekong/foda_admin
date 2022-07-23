import 'dart:async';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagePickerService {
  /// Returns byte lists of selected images, or null if no image was selected
  Future<Uint8List?> pickImages() async {
    Uint8List? image;
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.image);
    if (result != null) {
      PlatformFile file = result.files.first;
      image = file.bytes;
      return image;
    } else {
      return null;
    }
  }

  Future<String> uploadImageToDefaultBucket(Uint8List image, String storagePath, {String ref = 'foods'}) async {
    Reference firebaseStorageRef = FirebaseStorage.instance.ref(ref).child(storagePath);
    UploadTask uploadTask = firebaseStorageRef.putData(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot.ref.getDownloadURL();
  }
}

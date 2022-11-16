// ignore_for_file: unused_field

part of 'utilities.dart';

class Commons {
  final prefs = SharedPreferences.getInstance();
  final picker = ImagePicker();

  void setUID(String uid) async {
    final storage = await prefs;
    await storage.setString(myUID, uid);
  }

  Future<String?> getUID() async {
    final storage = await prefs;
    return storage.getString(myUID);
  }

  Future<bool?> removeUID() async {
    final storage = await prefs;
    return storage.remove(myUID);
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: message.text.make()));
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  Future<File> getImage() async {
    final pickerFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 10);
    return File(pickerFile!.path);
  }
}

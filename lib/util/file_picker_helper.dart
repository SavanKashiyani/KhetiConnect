

// class MyFilePickerHelper {
//   static const _platform = MethodChannel('get_download_directory');
//
//   Future<bool> saveFileToStorage(
//       {required String filePath, required String fileName}) async {
//     if (Platform.isIOS) {
//       var result = await OpenFile.open(filePath);
//       if (result.type != ResultType.done) {
//         return true;
//       }
//     } else {
//       var tmp = DateTime.now().toIso8601String();
//       var dir = await _downloadsDirectory;
//       var file = File(filePath);
//       var newFile = await file.copy("${dir.path}/$tmp-$fileName");
//       return true;
//     }
//     return false;
//   }
//
//   Future<Directory> get _downloadsDirectory async {
//     final String? path = await _platform.invokeMethod('get_download_directory');
//     if (path == null) {
//       return await getTemporaryDirectory();
//     }
//     return Directory(path);
//   }
// }

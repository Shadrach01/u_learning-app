import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:ulearning_app/common/services/storage.dart';

import 'firebase_options.dart';

class Global {
  static late StorageService storageService;

  static Future init() async {
    // ensure that all dependencies have been initialized
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    storageService = await StorageService().init();
  }
}

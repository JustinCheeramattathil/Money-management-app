import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Screens/splash.dart';
import 'db/category/category_db.dart';
import 'models/category/category_model.dart';
import 'models/transaction/transaction_model.dart';

Future<void> main() async {
  final obj1 = CategoryDB;
  final obj2 = CategoryDB;

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}

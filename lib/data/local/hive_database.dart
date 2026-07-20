import 'package:hive_flutter/hive_flutter.dart';

import 'hive_boxes.dart';

class HiveDatabase {
  HiveDatabase._();

  static Future<void> init() async {
    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox<Map>(HiveBoxes.users),
      Hive.openBox<Map>(HiveBoxes.drivers),
      Hive.openBox(HiveBoxes.session),
      Hive.openBox(HiveBoxes.settings),
      Hive.openBox<Map>(HiveBoxes.shipments),
    ]);
  }

  static Box<Map> get users => Hive.box<Map>(HiveBoxes.users);
  static Box<Map> get drivers => Hive.box<Map>(HiveBoxes.drivers);
  static Box get session => Hive.box(HiveBoxes.session);
  static Box get settings => Hive.box(HiveBoxes.settings);
  static Box<Map> get shipments => Hive.box<Map>(HiveBoxes.shipments);
}

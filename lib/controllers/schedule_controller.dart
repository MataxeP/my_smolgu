import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class ScheduleController extends GetxController {
  final databaseReference = FirebaseDatabase.instance.reference();

  void readData() {
    databaseReference.child("Факультеты").once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }
}

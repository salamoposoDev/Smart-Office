// import 'package:firebase_database/firebase_database.dart';

// class FirebaseService {
//   final DatabaseReference _dataRef =
//       FirebaseDatabase.instance.ref().child('data');

//   Future<Map<String, dynamic>> getData() async {
//     final dataSnapshot = _dataRef..child('dimmer').once();
//     return dataSnapshot.onValue;
//   }

//   Future<void> updateSuhu(int newSuhu) async {
//     await _dataRef.update({'suhu': newSuhu});
//   }
// }

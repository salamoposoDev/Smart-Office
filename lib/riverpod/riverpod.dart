import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedPathProviders = StateProvider<String>((ref) => 'dimmer');

final dimmerProvider = StreamProvider.family<num, String>((ref, sensorsPath) {
  // Future.delayed(Duration(seconds: 1));
  return FirebaseDatabase.instance.ref(sensorsPath).onValue.map((event) {
    if (event.snapshot.value != null) {
      final data = event.snapshot.value as num;
      return data;
    } else {
      return 0;
    }
  });
});

final pirSensorProvider =
    StreamProvider.family<String, String>((ref, sensorsPath) {
  // Future.delayed(Duration(seconds: 1));
  return FirebaseDatabase.instance.ref(sensorsPath).onValue.map((event) {
    if (event.snapshot.value != null) {
      final data = event.snapshot.value as String;
      return data;
    } else {
      return '';
    }
  });
});

final lightSensorProvider =
    StreamProvider.family<String, String>((ref, sensorsPath) {
  // Future.delayed(Duration(seconds: 1));
  return FirebaseDatabase.instance.ref(sensorsPath).onValue.map((event) {
    if (event.snapshot.value != null) {
      final data = event.snapshot.value as String;
      return data;
    } else {
      return '';
    }
  });
});

final ruangTamuAutomationProvider =
    StreamProvider.family<bool, String>((ref, sensorsPath) {
  // Future.delayed(Duration(seconds: 1));
  return FirebaseDatabase.instance.ref(sensorsPath).onValue.map((event) {
    if (event.snapshot.value != null) {
      final data = event.snapshot.value as bool;
      return data;
    } else {
      return false;
    }
  });
});

final lampuTerasValueProvider =
    StreamProvider.family<bool, String>((ref, sensorsPath) {
  // Future.delayed(Duration(seconds: 1));
  return FirebaseDatabase.instance.ref(sensorsPath).onValue.map((event) {
    if (event.snapshot.value != null) {
      final data = event.snapshot.value as bool;
      return data;
    } else {
      return false;
    }
  });
});

final lampuTerasAutomationProvider =
    StreamProvider.family<bool, String>((ref, sensorsPath) {
  // Future.delayed(Duration(seconds: 1));
  return FirebaseDatabase.instance.ref(sensorsPath).onValue.map((event) {
    if (event.snapshot.value != null) {
      final data = event.snapshot.value as bool;
      return data;
    } else {
      return false;
    }
  });
});

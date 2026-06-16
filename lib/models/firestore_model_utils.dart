import 'package:cloud_firestore/cloud_firestore.dart';

sealed class FirestoreModelUtils {
  static DateTime? fromTimestamp(Timestamp? timestamp) {
    return timestamp?.toDate();
  }

  static Timestamp? toTimestamp(DateTime? dateTime) {
    return dateTime != null ? Timestamp.fromDate(dateTime) : null;
  }
}

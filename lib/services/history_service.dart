import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryService {
  static String collection = "history";
  static Future<List> fetchDriverHistory(String id) async {
    List rideHistory = [];
    QuerySnapshot historySnap = await FirebaseFirestore.instance
        .collection(collection)
        .where("driverId", isEqualTo: id)
        .get();
    for (var element in historySnap.docs) {
      rideHistory.add(element.data() as Map);
    }
    return rideHistory;
  }
}

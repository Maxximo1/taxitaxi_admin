import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserService {
  Future<List<UserModel>> fetchUsers() async {
    List<UserModel> users = [];
    QuerySnapshot snaps =
        await FirebaseFirestore.instance.collection("users").get();

    for (var element in snaps.docs) {
      users.add(await UserModel.fromSnapshot(element));
    }
    return users.reversed.toList();
  }
}

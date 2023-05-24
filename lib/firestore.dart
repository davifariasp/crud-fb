import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_teste/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Firestore {
  Future<List<User>> carregarDB() async {
    List<User> usersSnapshot = [];

    final docRef = FirebaseFirestore.instance.collection("users").withConverter(
        fromFirestore: User.fromFirestore,
        toFirestore: (User user, _) => user.toFirestore());

    await docRef.get().then(
      (querySnapshot) {
        debugPrint("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          User user = docSnapshot.data();
          user.id = docSnapshot.id;
          usersSnapshot.add(user);
          debugPrint(
              '${docSnapshot.id} => ${user.name}, ${user.age}, ${user.createOn}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );

    return usersSnapshot;
  }

  adicionar(String name, String age) async {
    DateTime data = DateTime.now();
    final datapt = DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY, 'pt_Br')
        .format(data);

    User user = User(
      name: name,
      age: int.parse(age),
      createOn: datapt.toString(),
    );

    final docRef = FirebaseFirestore.instance.collection("users").withConverter(
        fromFirestore: User.fromFirestore,
        toFirestore: (User user, options) => user.toFirestore());

    await docRef.add(user).then((DocumentReference doc) =>
        debugPrint("DocumentSnapshot added with ID: ${doc.id}"));
  }

  atualizar() {}

  delete(id) async {
    await FirebaseFirestore.instance.collection('users').doc(id).delete().then(
          (doc) => debugPrint("Document deleted"),
          onError: (e) => debugPrint("Error updating document $e"),
        );
  }
}

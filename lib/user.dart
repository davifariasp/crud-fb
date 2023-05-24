import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? name;
  final int? age;
  final String? createOn;
  late String? id;

  User({this.name, this.age, this.createOn, this.id});

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return User(
      name: data?['name'],
      age: data?['age'],
      createOn: data?['createOn'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (age != null) "age": age,
      if (createOn != null) "createOn": createOn,
    };
  }
}

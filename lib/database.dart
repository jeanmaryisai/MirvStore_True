import 'package:firebase_database/firebase_database.dart';

import 'components/data.dart';
import 'models/user.dart';
final DatabaseReference _database = FirebaseDatabase.instance.ref();
abstract class UserDb{


  Future<void> retrieveUserData() async {
    try {
      DataSnapshot dataSnapshot = (await _database.child('users').once()).snapshot;
      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic> userData = dataSnapshot.value as Map<dynamic, dynamic>;
        List<User> retrievedUsers = [];

        userData.forEach((key, value) {
          User user = User(
            id: key, // Assign the id value from the key in the Firebase snapshot
            profile: value['profile'],
            username: value['username'],
            password: value['password'],
            bio: value['bio'],
            isSeller: value['isSeller'],
            address: value['address'],
          );
          users.add(user);
        });

        // Add retrieved users to the existing list
        // users.addAll(retrievedUsers);
      }
    } catch (error) {
      print('Error retrieving user data: $error');
    }
  }

}
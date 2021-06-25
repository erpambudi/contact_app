part of 'services.dart';

class UsersServices {
  static CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> updateUser(UserData user) async {
    _userCollection.doc(user.id).set(
      {
        'email': user.email,
        'name': user.name,
      },
    );
  }

  static Future<ServicesReturnValue<UserData>> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      UserData user = UserData(
        id: id,
        email: data["email"],
        name: data['name'],
      );
      return ServicesReturnValue(value: user);
    } else {
      return ServicesReturnValue(message: "document not exists");
    }
  }
}

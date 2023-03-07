import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platzi_trips_app/User/model/user_model.dart';

class CloudFirestoreAPI {
  static const String users = 'users';
  static const String place = 'places';

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> updateUserData(UserModel user) async {
    CollectionReference usersCollection = _db.collection(users);
    DocumentReference ref = usersCollection.doc(user.uid);
    return ref.set({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myPlaces': user.myPlaces,
      'myFavoritePlaces': user.myFavoritePlaces,
      'lastSignIn': DateTime.now()
    }, SetOptions(merge: true));
  }
}

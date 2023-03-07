import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/Place/model/place.dart';
import 'package:platzi_trips_app/User/model/user_model.dart';
import 'package:platzi_trips_app/User/repository/auth_repository.dart';

import '../repository/cloud_firestore_repository.dart';

class UserBloc implements Bloc {
  final _auth_repository = AuthRepository();

  //Flujo de datos - Streams
  //Stream - Firebase
  //StreamController
  Stream<User?> streamFirebase = FirebaseAuth.instance.authStateChanges();

  //Quiero monitorear el estado de la sesion en la pantalla SignIn
  Stream<User?> get authStatus => streamFirebase;

  //Casos de uso
  //1. SignIn a la aplicación Google
  Future<UserCredential> signIn() => _auth_repository.signInFirebase();

  //2. Registrar usuario en base de datos
  final _cloudFireStoreRepository = CloudFireStoreRepository();

  void updateUserData(UserModel user) =>
      _cloudFireStoreRepository.updateUserDataFireStore(user);

  Future<void> updatePlaceData(InfoPlace place) =>
      _cloudFireStoreRepository.updatePlaceData(place);

  // Cierre de sesión
  signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {}
}

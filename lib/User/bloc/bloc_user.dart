import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/Place/model/place.dart';
import 'package:platzi_trips_app/Place/repository/firebase_storage_repository.dart';
import 'package:platzi_trips_app/User/model/user_model.dart';
import 'package:platzi_trips_app/User/repository/auth_repository.dart';
import 'package:platzi_trips_app/User/repository/cloud_firestore_api.dart';

import '../../Place/ui/widgets/card_image.dart';
import '../repository/cloud_firestore_repository.dart';
import '../ui/widgets/profile_place.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

class UserBloc implements Bloc {
  final _auth_repository = AuthRepository();

  //Flujo de datos - Streams
  //Stream - Firebase
  //StreamController
  Stream<User?> streamFirebase = FirebaseAuth.instance.authStateChanges();

  //Quiero monitorear el estado de la sesion en la pantalla SignIn
  Stream<User?> get authStatus => streamFirebase;

  Future<User?> currentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  //Casos de uso
  //1. SignIn a la aplicación Google
  Future<UserCredential> signIn() => _auth_repository.signInFirebase();

  //2. Registrar usuario en base de datos
  final _cloudFireStoreRepository = CloudFireStoreRepository();

  void updateUserData(UserModel user) =>
      _cloudFireStoreRepository.updateUserDataFireStore(user);

  Future<void> updatePlaceData(PlaceModel place) =>
      _cloudFireStoreRepository.updatePlaceData(place);

  //Metodo para agregar un listener de escucha ante cualquier cambio en la
  //colecion de PLACES
  Stream<QuerySnapshot> placesListStream = FirebaseFirestore.instance
      .collection(CloudFirestoreAPI.places)
      .snapshots();

  Stream<QuerySnapshot> get placesStream => placesListStream;

  //Metodo para construir lista de Places despues de haber obtenido los datos de Places de CloudFirestore
  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFireStoreRepository.buildMyPlaces(placesListSnapshot);

  //Metodo pAra obtener todos los Places de la Base de datos
  List<PlaceModel> buildPlaces(
          List<DocumentSnapshot> placesListSnapshot, UserModel user) =>
      _cloudFireStoreRepository.buildPlaces(placesListSnapshot, user);

  //Metodo para seleccionar solo los PLaces del usuario logueado
  Stream<QuerySnapshot> myPlacesListStream(String uid) => FirebaseFirestore
      .instance
      .collection(CloudFirestoreAPI.places)
      .where("userOwner",
          isEqualTo:
              FirebaseFirestore.instance.doc("${CloudFirestoreAPI.users}/$uid"))
      .snapshots();

  //Metodo para incrementar los like de un Place
  Future likePlace(PlaceModel place, String uid) =>
      _cloudFireStoreRepository.likePlace(place, uid);

  final _firebaseStorageRepository = FirebaseStorageRepository();

  Future<UploadTask> uploadFile(String path, File image) =>
      _firebaseStorageRepository.uploadFile(path, image);

  // Cierre de sesión
  signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {}
}

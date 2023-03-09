import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/User/bloc/bloc_user.dart';
import 'package:platzi_trips_app/User/model/user_model.dart';
import 'package:platzi_trips_app/User/ui/screens/header_profile.dart';
import 'package:platzi_trips_app/User/ui/widgets/profile_background.dart';
import '../widgets/profile_places_list.dart';

class ProfileTrips extends StatelessWidget {
  late UserBloc userBloc;

  ProfileTrips({super.key});

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return const CircularProgressIndicator();
          case ConnectionState.active:
          case ConnectionState.done:
            return showProfileData(snapshot);
        }
      },
    );
  }

  Widget showProfileData(AsyncSnapshot snapshot) {
    if (!snapshot.hasData || snapshot.hasError) {
      print("No Logeado");
      return Stack(
        children: <Widget>[
          BackgroundProfile(),
          ListView(
            children: const <Widget>[Text("Usuario no logeado, Haz Login.")],
          ),
        ],
      );
    } else {
      print("LOGEADO");
      var user = UserModel(
          uid: snapshot.data.uid,
          name: snapshot.data.displayName,
          email: snapshot.data.email,
          photoURL: snapshot.data.photoURL);

      return Stack(
        children: <Widget>[
          BackgroundProfile(),
          ListView(
            children: <Widget>[
              HeaderProfile(user: user),
              PlacesList(user: user)
            ],
          ),
        ],
      );
    }
  }
}

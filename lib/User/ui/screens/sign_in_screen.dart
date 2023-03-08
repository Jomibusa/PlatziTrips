import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/User/bloc/bloc_user.dart';
import 'package:platzi_trips_app/User/model/user_model.dart';
import 'package:platzi_trips_app/platzi_trips_cupertino.dart';
import 'package:platzi_trips_app/widgets/button_green.dart';
import 'package:platzi_trips_app/widgets/gradient_back.dart';

class SignInScreen extends StatefulWidget {
  @override
  State createState() {
    return _SingInScreen();
  }
}

class _SingInScreen extends State<SignInScreen> {
  late UserBloc userBloc;
  late double screenWidth;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    screenWidth = MediaQuery.of(context).size.width;
    return _handleCurrentSession();
  }

  Widget _handleCurrentSession() {
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //snapshot - data - Object User
        if (!snapshot.hasData || snapshot.hasError) {
          return signInGoogleUI();
        } else {
          return PlatziTripsCupertino();
        }
      },
    );
  }

  Widget signInGoogleUI() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GradientBack(height: null),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: screenWidth - (screenWidth / 14),
                  //hago esta resta para colocarle margenes horizontales y ademas simular diferentes width de pantallas
                  child: const FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'Welcome \nThis is your Travel App',
                      style: TextStyle(
                          fontFamily: 'lato',
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              ButtonGreen(
                text: "Login with Gmail",
                onPressed: () {
                  userBloc.signIn().then((UserCredential user) {
                    userBloc.updateUserData(UserModel(
                        uid: user.user?.uid ?? '',
                        name: user.user?.displayName ?? '',
                        email: user.user?.email ?? '',
                        photoURL: user.user?.photoURL ?? ''));
                  });
                },
                width: 300.0,
                height: 50.0,
              )
            ],
          )
        ],
      ),
    );
  }
}

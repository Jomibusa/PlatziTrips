import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/User/bloc/bloc_user.dart';
import 'circle_button.dart';

class ButtonsBar extends StatelessWidget {
  late UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            //Cambiar la contraseña
            CircleButton(
              true,
              Icons.change_circle_outlined,
              20.0,
              const Color.fromRGBO(255, 255, 255, 0.6),
              onPressed: () => {},
            ),
            //Añadir un nuevo lugar
            CircleButton(
                false, Icons.add, 40.0, const Color.fromRGBO(255, 255, 255, 1),
                onPressed: () => {}),
            //Cerrar la sesión
            CircleButton(true, Icons.exit_to_app, 20.0,
                const Color.fromRGBO(255, 255, 255, 0.6),
                onPressed: () => {userBloc.signOut()})
          ],
        ));
  }
}
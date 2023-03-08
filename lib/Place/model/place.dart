import 'package:platzi_trips_app/User/model/user_model.dart';

class InfoPlace {
  String? id;
  String name;
  String description;
  String? urlImage;
  int? likes;
  //UserModel? userOwner;

  InfoPlace({
    required this.name,
    required this.description,
    this.urlImage,
    this.id,
    this.likes,
    //this.userOwner
  });
}

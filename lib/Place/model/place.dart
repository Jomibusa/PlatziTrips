class PlaceModel {
  String? id;
  String name;
  String description;
  String? urlImage;
  int? likes;
  bool liked;

  PlaceModel(this.liked,
      {required this.name,
      required this.description,
      this.urlImage,
      this.id,
      this.likes});
}

class Store {
  String name;
  String image;
  String description;

  Store({required this.name, required this.description, required this.image});
  //create an instance of model class from a JSON object
  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
        name: json["title"],
        description: json["description"],
        image: json["image"]);
  }
}
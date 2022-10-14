abstract class Jsonable {
  Map<String, dynamic> toJson();
  fromJson(Map<String, dynamic> json);
}
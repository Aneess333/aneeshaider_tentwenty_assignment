import 'package:tentwenty_assessment/helper/constants/constant_resources.dart';

class GenreHandler{


  Map<int, String> genreMap = {
    for (var genre in ConstantsResource.GENERS) genre["id"]: genre["name"]
  };
  String getGenresNames(List<int> ids) {
    List<String> genreNames = ids.map((id) => genreMap[id] ?? "Unknown Genre").toList();
    genreNames.removeWhere((v)=>v=="Unknown Genre");
    return genreNames.join(", ");
  }
  String getGenreName(int id) {
    return genreMap[id] ?? "Unknown Genre";
  }


}
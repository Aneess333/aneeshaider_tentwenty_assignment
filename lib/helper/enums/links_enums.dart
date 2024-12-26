import 'package:json_annotation/json_annotation.dart';

enum Iso31661 {
  US,
}

enum Iso6391 {
  EN,
}

enum Site {
  YouTube,
}

@JsonSerializable()
class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

final iso31661Values = EnumValues({
  "US": Iso31661.US,
});

final iso6391Values = EnumValues({
  "en": Iso6391.EN,
});



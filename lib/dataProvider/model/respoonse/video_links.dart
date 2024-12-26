import 'package:json_annotation/json_annotation.dart';
import '../../../helper/enums/links_enums.dart';

part 'video_links.g.dart';

@JsonSerializable()
class VideoLink {
  @JsonKey(name: 'iso_639_1')
  String? iso6391;
  @JsonKey(name: 'iso_3166_1')
  String? iso31661;
  @JsonKey(name: 'name')

  String? name;
  @JsonKey(name: 'key')

  String? key;
  @JsonKey(name: 'site')

  String? site;
  @JsonKey(name: 'size')

  int? size;
  @JsonKey(name: 'type')

  String? type;
  @JsonKey(name: 'official')

  bool? official;
  @JsonKey(name: 'published_at')

  DateTime? publishedAt;
  @JsonKey(name: 'id')

  String? id;

  VideoLink({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
  });

  factory VideoLink.fromJson(Map<String, dynamic> json) => _$VideoLinkFromJson(json);

  Map<String, dynamic> toJson() => _$VideoLinkToJson(this);
}

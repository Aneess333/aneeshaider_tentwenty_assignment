import 'package:json_annotation/json_annotation.dart';
import 'package:tentwenty_assessment/dataProvider/model/respoonse/video_links.dart';

part 'video_list.g.dart';

@JsonSerializable()
class VideoList {
  @JsonKey(name: 'id')

  int? id;
  @JsonKey(name: 'results')

  List<VideoLink>? videoLinks;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  @JsonKey(name: 'status_message')
  final String? statusMessage;
  @JsonKey(name: 'success')
  final bool? success;

  VideoList({
    this.id,
    this.videoLinks,
    this.success,
    this.statusMessage,
    this.statusCode
  });

  factory VideoList.fromJson(Map<String, dynamic> json) => _$VideoListFromJson(json);

  Map<String, dynamic> toJson() => _$VideoListToJson(this);
}

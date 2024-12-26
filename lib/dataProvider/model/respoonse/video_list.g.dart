// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoList _$VideoListFromJson(Map<String, dynamic> json) => VideoList(
      id: (json['id'] as num?)?.toInt(),
      videoLinks: (json['results'] as List<dynamic>?)
          ?.map((e) => VideoLink.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool?,
      statusMessage: json['status_message'] as String?,
      statusCode: (json['status_code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VideoListToJson(VideoList instance) => <String, dynamic>{
      'id': instance.id,
      'results': instance.videoLinks,
      'status_code': instance.statusCode,
      'status_message': instance.statusMessage,
      'success': instance.success,
    };

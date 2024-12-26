import 'package:json_annotation/json_annotation.dart';
import 'package:tentwenty_assessment/dataProvider/model/respoonse/error_response.dart';
import 'package:tentwenty_assessment/dataProvider/model/respoonse/results.dart';
import 'dates.dart';

part 'main_response.g.dart';

@JsonSerializable()
class MainResponse {
  @JsonKey(name: 'dates')
  final Dates? dates;
  @JsonKey(name: 'page')
  final int? page;
  @JsonKey(name: 'status_code')
  final int? statusCode;
  @JsonKey(name: 'status_message')
  final String? statusMessage;
  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'results')
  final List<Result>? results;
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @JsonKey(name: 'total_results')
  final int? totalResults;
  final ErrorResponse? errorResponse;

  MainResponse({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
    this.errorResponse,
    this.success,
    this.statusCode,
    this.statusMessage
  });

  factory MainResponse.fromJson(Map<String, dynamic> json) => _$MainResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MainResponseToJson(this);
}

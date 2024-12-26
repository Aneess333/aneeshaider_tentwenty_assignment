import 'package:json_annotation/json_annotation.dart';

part 'production_company_model.g.dart';

@JsonSerializable()
class ProductionCompany {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'logo_path')
  final String? logoPath;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'origin_country')
  final String? originCountry;

  ProductionCompany({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) => _$ProductionCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyToJson(this);
}

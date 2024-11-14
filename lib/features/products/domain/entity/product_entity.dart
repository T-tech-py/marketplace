// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_entity.freezed.dart';
part 'product_entity.g.dart';

@freezed
class ProductEntity with _$ProductEntity {
  @JsonSerializable(explicitToJson: true)
  const factory ProductEntity({
    required int id,
    required String title,
    required int price,
    required String description,
    @JsonKey(name: 'category') required  Category category,
    required List<String> images,
  })= _ProductEntity;

  factory ProductEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductEntityFromJson(json);

}

@freezed
class Category with _$Category {

  @JsonSerializable(explicitToJson: true)
  const factory Category({
   required int id,
    required String name,
    required String image,
  })= _Category ;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

}

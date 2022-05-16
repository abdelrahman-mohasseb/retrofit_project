// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dog _$DogFromJson(Map<String, dynamic> json) => Dog(
      id: json['id'] as int?,
      name: json['name'] as String?,
      temperament: json['temperament'] as String?,
      lifeSpan: json['life_span'] as String?,
      origin: json['origin'] as String?,
      bredFor: json['bred_for'] as String?,
      referenceImageID: json['reference_image_id'] as String?,
      height: json['height'] == null
          ? null
          : Height.fromJson(json['height'] as Map<String, dynamic>),
      weight: json['weight'] == null
          ? null
          : Weight.fromJson(json['weight'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DogToJson(Dog instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'temperament': instance.temperament,
      'life_span': instance.lifeSpan,
      'origin': instance.origin,
      'bred_for': instance.bredFor,
      'reference_image_id': instance.referenceImageID,
      'height': instance.height,
      'weight': instance.weight,
    };

Height _$HeightFromJson(Map<String, dynamic> json) => Height(
      metric: json['metric'] as String?,
      imperial: json['imperial'] as String?,
    );

Map<String, dynamic> _$HeightToJson(Height instance) => <String, dynamic>{
      'metric': instance.metric,
      'imperial': instance.imperial,
    };

Weight _$WeightFromJson(Map<String, dynamic> json) => Weight(
      metric: json['metric'] as String?,
      imperial: json['imperial'] as String?,
    );

Map<String, dynamic> _$WeightToJson(Weight instance) => <String, dynamic>{
      'metric': instance.metric,
      'imperial': instance.imperial,
    };

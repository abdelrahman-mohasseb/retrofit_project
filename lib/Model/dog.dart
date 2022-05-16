import 'package:json_annotation/json_annotation.dart';
part 'dog.g.dart';

@JsonSerializable()
class Dog {
  int? id;
  String? name;
  String? temperament;
  @JsonKey(name: 'life_span')
  String? lifeSpan;
  @JsonKey(name: 'origin')
  String? origin;
  @JsonKey(name: 'bred_for')
  String? bredFor;
  @JsonKey(name: 'reference_image_id')
  String? referenceImageID;
  Height? height;
  Weight? weight;

  Dog(
      {this.id,
      this.name,
      this.temperament,
      this.lifeSpan,
      this.origin,
      this.bredFor,
      this.referenceImageID,
      this.height,
      this.weight});

  factory Dog.fromJson(Map<String, dynamic> json) => _$DogFromJson(json);
  Map<String, dynamic> toJson() => _$DogToJson(this);
}

extension Helpers on Dog {
  String get dogImageURL {
    if (this.referenceImageID == null) {
      return "";
    } else {
      return "https://cdn2.thedogapi.com/images/" +
          this.referenceImageID! +
          ".jpg";
    }
  }
}

@JsonSerializable()
class Height {
  String? metric;
  String? imperial;

  Height({this.metric, this.imperial});

  factory Height.fromJson(Map<String, dynamic> json) => _$HeightFromJson(json);
  Map<String, dynamic> toJson() => _$HeightToJson(this);
}

@JsonSerializable()
class Weight {
  String? metric;
  String? imperial;

  Weight({this.metric, this.imperial});

  factory Weight.fromJson(Map<String, dynamic> json) => _$WeightFromJson(json);
  Map<String, dynamic> toJson() => _$WeightToJson(this);
}

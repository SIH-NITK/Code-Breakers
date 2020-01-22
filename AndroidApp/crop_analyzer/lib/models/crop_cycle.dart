import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'crop_cycle.g.dart';

abstract class CropCycle implements Built<CropCycle, CropCycleBuilder> {
  static Serializer<CropCycle> get serializer => _$cropCycleSerializer;

  @BuiltValueField(wireName: 'start_date')
  String get harvestDate;

  @BuiltValueField(wireName: 'end_date')
  String get sowingDate;

  @BuiltValueField(wireName: 'yield')
  double get quantity;

  @BuiltValueField(wireName: 'imgs_path')
  BuiltList<String> get images;

  CropCycle._();
  factory CropCycle([void Function(CropCycleBuilder) updates]) = _$CropCycle;
}
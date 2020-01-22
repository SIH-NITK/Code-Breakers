import 'package:built_value/serializer.dart';
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';


import 'crop_cycle.dart';

part 'crop_cycles.g.dart';

abstract class CropCycles implements Built<CropCycles, CropCyclesBuilder> {
  static Serializer<CropCycles> get serializer => _$cropCyclesSerializer;

  @BuiltValueField(wireName: 'min_year')
  int get minYear;
  
  @BuiltValueField(wireName: 'max_year')
  int get maxYear;

  @BuiltValueField(wireName: 'crop_cycle')
  BuiltList<CropCycle> get cropCycles;

  CropCycles._();
  factory CropCycles([void Function(CropCyclesBuilder) updates]) = _$CropCycles;
}
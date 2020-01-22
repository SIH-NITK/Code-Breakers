// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop_cycle.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CropCycle> _$cropCycleSerializer = new _$CropCycleSerializer();

class _$CropCycleSerializer implements StructuredSerializer<CropCycle> {
  @override
  final Iterable<Type> types = const [CropCycle, _$CropCycle];
  @override
  final String wireName = 'CropCycle';

  @override
  Iterable<Object> serialize(Serializers serializers, CropCycle object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'start_date',
      serializers.serialize(object.harvestDate,
          specifiedType: const FullType(String)),
      'end_date',
      serializers.serialize(object.sowingDate,
          specifiedType: const FullType(String)),
      'yield',
      serializers.serialize(object.quantity,
          specifiedType: const FullType(double)),
      'imgs_path',
      serializers.serialize(object.images,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  CropCycle deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CropCycleBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'start_date':
          result.harvestDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'end_date':
          result.sowingDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'yield':
          result.quantity = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'imgs_path':
          result.images.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$CropCycle extends CropCycle {
  @override
  final String harvestDate;
  @override
  final String sowingDate;
  @override
  final double quantity;
  @override
  final BuiltList<String> images;

  factory _$CropCycle([void Function(CropCycleBuilder) updates]) =>
      (new CropCycleBuilder()..update(updates)).build();

  _$CropCycle._({this.harvestDate, this.sowingDate, this.quantity, this.images})
      : super._() {
    if (harvestDate == null) {
      throw new BuiltValueNullFieldError('CropCycle', 'harvestDate');
    }
    if (sowingDate == null) {
      throw new BuiltValueNullFieldError('CropCycle', 'sowingDate');
    }
    if (quantity == null) {
      throw new BuiltValueNullFieldError('CropCycle', 'quantity');
    }
    if (images == null) {
      throw new BuiltValueNullFieldError('CropCycle', 'images');
    }
  }

  @override
  CropCycle rebuild(void Function(CropCycleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CropCycleBuilder toBuilder() => new CropCycleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CropCycle &&
        harvestDate == other.harvestDate &&
        sowingDate == other.sowingDate &&
        quantity == other.quantity &&
        images == other.images;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, harvestDate.hashCode), sowingDate.hashCode),
            quantity.hashCode),
        images.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CropCycle')
          ..add('harvestDate', harvestDate)
          ..add('sowingDate', sowingDate)
          ..add('quantity', quantity)
          ..add('images', images))
        .toString();
  }
}

class CropCycleBuilder implements Builder<CropCycle, CropCycleBuilder> {
  _$CropCycle _$v;

  String _harvestDate;
  String get harvestDate => _$this._harvestDate;
  set harvestDate(String harvestDate) => _$this._harvestDate = harvestDate;

  String _sowingDate;
  String get sowingDate => _$this._sowingDate;
  set sowingDate(String sowingDate) => _$this._sowingDate = sowingDate;

  double _quantity;
  double get quantity => _$this._quantity;
  set quantity(double quantity) => _$this._quantity = quantity;

  ListBuilder<String> _images;
  ListBuilder<String> get images =>
      _$this._images ??= new ListBuilder<String>();
  set images(ListBuilder<String> images) => _$this._images = images;

  CropCycleBuilder();

  CropCycleBuilder get _$this {
    if (_$v != null) {
      _harvestDate = _$v.harvestDate;
      _sowingDate = _$v.sowingDate;
      _quantity = _$v.quantity;
      _images = _$v.images?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CropCycle other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CropCycle;
  }

  @override
  void update(void Function(CropCycleBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CropCycle build() {
    _$CropCycle _$result;
    try {
      _$result = _$v ??
          new _$CropCycle._(
              harvestDate: harvestDate,
              sowingDate: sowingDate,
              quantity: quantity,
              images: images.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'images';
        images.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CropCycle', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop_cycles.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CropCycles> _$cropCyclesSerializer = new _$CropCyclesSerializer();

class _$CropCyclesSerializer implements StructuredSerializer<CropCycles> {
  @override
  final Iterable<Type> types = const [CropCycles, _$CropCycles];
  @override
  final String wireName = 'CropCycles';

  @override
  Iterable<Object> serialize(Serializers serializers, CropCycles object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'min_year',
      serializers.serialize(object.minYear, specifiedType: const FullType(int)),
      'max_year',
      serializers.serialize(object.maxYear, specifiedType: const FullType(int)),
      'crop_cycle',
      serializers.serialize(object.cropCycles,
          specifiedType:
              const FullType(BuiltList, const [const FullType(CropCycle)])),
    ];

    return result;
  }

  @override
  CropCycles deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CropCyclesBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'min_year':
          result.minYear = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'max_year':
          result.maxYear = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'crop_cycle':
          result.cropCycles.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CropCycle)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$CropCycles extends CropCycles {
  @override
  final int minYear;
  @override
  final int maxYear;
  @override
  final BuiltList<CropCycle> cropCycles;

  factory _$CropCycles([void Function(CropCyclesBuilder) updates]) =>
      (new CropCyclesBuilder()..update(updates)).build();

  _$CropCycles._({this.minYear, this.maxYear, this.cropCycles}) : super._() {
    if (minYear == null) {
      throw new BuiltValueNullFieldError('CropCycles', 'minYear');
    }
    if (maxYear == null) {
      throw new BuiltValueNullFieldError('CropCycles', 'maxYear');
    }
    if (cropCycles == null) {
      throw new BuiltValueNullFieldError('CropCycles', 'cropCycles');
    }
  }

  @override
  CropCycles rebuild(void Function(CropCyclesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CropCyclesBuilder toBuilder() => new CropCyclesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CropCycles &&
        minYear == other.minYear &&
        maxYear == other.maxYear &&
        cropCycles == other.cropCycles;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, minYear.hashCode), maxYear.hashCode), cropCycles.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CropCycles')
          ..add('minYear', minYear)
          ..add('maxYear', maxYear)
          ..add('cropCycles', cropCycles))
        .toString();
  }
}

class CropCyclesBuilder implements Builder<CropCycles, CropCyclesBuilder> {
  _$CropCycles _$v;

  int _minYear;
  int get minYear => _$this._minYear;
  set minYear(int minYear) => _$this._minYear = minYear;

  int _maxYear;
  int get maxYear => _$this._maxYear;
  set maxYear(int maxYear) => _$this._maxYear = maxYear;

  ListBuilder<CropCycle> _cropCycles;
  ListBuilder<CropCycle> get cropCycles =>
      _$this._cropCycles ??= new ListBuilder<CropCycle>();
  set cropCycles(ListBuilder<CropCycle> cropCycles) =>
      _$this._cropCycles = cropCycles;

  CropCyclesBuilder();

  CropCyclesBuilder get _$this {
    if (_$v != null) {
      _minYear = _$v.minYear;
      _maxYear = _$v.maxYear;
      _cropCycles = _$v.cropCycles?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CropCycles other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CropCycles;
  }

  @override
  void update(void Function(CropCyclesBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CropCycles build() {
    _$CropCycles _$result;
    try {
      _$result = _$v ??
          new _$CropCycles._(
              minYear: minYear,
              maxYear: maxYear,
              cropCycles: cropCycles.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'cropCycles';
        cropCycles.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CropCycles', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

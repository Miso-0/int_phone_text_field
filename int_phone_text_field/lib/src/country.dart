import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:int_phone_text_field/src/country_codes.dart';


part 'country.freezed.dart';
part 'country.g.dart';

@freezed
class Country with _$Country {
  const factory Country({
    required String name,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'dial_code') required String dialCode,
    required String code,
  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
}



final countries = countryCodes.map((e) => Country.fromJson(e)).toList();
final defaultCountry = countries.firstWhere((e) => e.code == 'AU');
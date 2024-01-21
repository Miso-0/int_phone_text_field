import 'package:flutter/material.dart';
import 'package:int_phone_text_field/src/country.dart';


class CountryPicker extends StatefulWidget {
  const CountryPicker({
    super.key,
    this.onChanged,
    this.decoration,
    this.initialCountry,
    this.arrowIcon,
    this.textStyle,
  });

  final void Function(String country)? onChanged;
  final InputDecoration? decoration;
  final Country? initialCountry;
  final Widget? arrowIcon;
  final TextStyle? textStyle;

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  Country selectedCountry = defaultCountry;

  @override
  void initState() {
    super.initState();
    setSelectedCountry(widget.initialCountry ?? defaultCountry);
  }

  void setSelectedCountry(Country country) {
    setState(() {
      selectedCountry = country;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return DropdownButton<Country>(
      // Initial Value
      value: selectedCountry,

      // Down Arrow Icon
      icon: widget.arrowIcon ??
          Icon(
            Icons.arrow_drop_down,
            size: 15,
            color: Theme.of(context).colorScheme.tertiary,
          ),
      isExpanded: true,
      underline: const SizedBox(),
      borderRadius: BorderRadius.circular(5),
      // Array list of items
      items: countries.map((Country country) {
        return DropdownMenuItem(
          value: country,
          child: Text(
            country.name,
            style: widget.textStyle,
          ),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (Country? newValue) {
        if (newValue == null) return;
        setSelectedCountry(newValue);
        widget.onChanged?.call(newValue.name);
      },
    );
  }
}

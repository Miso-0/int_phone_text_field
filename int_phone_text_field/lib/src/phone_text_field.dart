import 'package:flutter/material.dart';
import 'package:int_phone_text_field/src/country.dart';


class PhoneTextField extends StatefulWidget {
  const PhoneTextField({
    super.key,
    this.onChanged,
    this.decoration,
    this.controller,
    this.initialValue,
    this.initialCountry,
    this.arrowIcon,
    this.textStyle,
  });

  final String? initialValue;
  final TextEditingController? controller;
  final void Function(String value)? onChanged;
  final InputDecoration? decoration;
  final Country? initialCountry;
  final Widget? arrowIcon;
  final TextStyle? textStyle;

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
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
    return Row(
      children: [
        PopupMenuButton(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(selectedCountry.dialCode, style: widget.textStyle),
              const SizedBox(width: 5),
              widget.arrowIcon ??
                  Icon(
                    Icons.arrow_drop_down,
                    size: 15,
                    color: Theme.of(context).colorScheme.tertiary,
                  )
            ],
          ),
          itemBuilder: (context) {
            return countries
                .map(
                  (e) => PopupMenuItem(
                    value: e,
                    child: Text(
                      '(${e.dialCode}) ${e.name}',
                      style: widget.textStyle,
                    ),
                  ),
                )
                .toList();
          },
          onSelected: (Country country) {
            setSelectedCountry(country);
          },
        ),
        const SizedBox(width: 5),
        Expanded(
          child: TextFormField(
            initialValue: widget.initialValue,
            decoration: widget.decoration,
            controller: widget.controller,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final phone = '${selectedCountry.dialCode}$value';
              widget.onChanged?.call(phone);
            },
          ),
        ),
      ],
    );
  }
}

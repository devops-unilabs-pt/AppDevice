import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  String? dropdownvalue;
  List<String> brands;

  DropDown(this.dropdownvalue, this.brands, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: dropdownvalue,
        hint: const Text("Selecione a Marca"),
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        items: brands.map((String brands) {
          return DropdownMenuItem(
              value: brands,
              child: Text(brands, style: const TextStyle(fontSize: 13)));
        }).toList(),
        onChanged: (String? newValue) {
          dropdownvalue = newValue!;
        });
  }
}

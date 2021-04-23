import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchBar extends StatelessWidget {
  SearchBar({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  final ValueSetter<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('searchBar_textField'),
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        hintText: 'Search for your city',
      ),
      onChanged: onChanged,
    );
  }
}

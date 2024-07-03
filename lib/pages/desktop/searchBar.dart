import 'package:ICTC_Website/pages/desktop/morePrograms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function(String) onChanged;

  const SearchBar({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 350,
        height: 40,
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            hintText: "Search...",
            hintStyle: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
              height: 0,
              textBaseline: TextBaseline.alphabetic,
            ),
            prefixIcon: const Icon(CupertinoIcons.search, size: 16),
            prefixIconColor: Colors.black,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

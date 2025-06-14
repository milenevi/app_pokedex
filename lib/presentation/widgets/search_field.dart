import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hintText;

  const SearchField({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Search Pokémon',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          border: const Border(
            bottom: BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 26, color: Colors.black.withAlpha(153)),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Colors.black.withAlpha(102),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  isDense: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  suffixIcon: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: controller,
                    builder: (context, value, child) {
                      return value.text.isNotEmpty
                          ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => controller.clear(),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            splashRadius: 16,
                          )
                          : const SizedBox.shrink();
                    },
                  ),
                ),
                style: const TextStyle(color: Colors.black87, fontSize: 16),
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

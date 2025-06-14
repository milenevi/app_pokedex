import 'package:flutter/material.dart';
import '../../domain/entities/character.dart';
import 'characteristic_card.dart';

class PhysicalCharacteristicsSection extends StatelessWidget {
  final Character character;

  const PhysicalCharacteristicsSection({Key? key, required this.character})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Physical Characteristics',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: CharacteristicCard(
                label: 'Height',
                value: '${character.height}',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CharacteristicCard(
                label: 'Weight',
                value: '${character.weight}',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../ui/app_colors.dart';
import '../ui/app_size_constants.dart';

class InfoMessage extends StatelessWidget {
  const InfoMessage({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kSpacingSmall),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadiusMedium),
        color: AppColors.lightGrey,
      ),
      child: Row(
        children: [
          const SizedBox(width: kSpacingSmall),
          const Icon(Icons.info, color: Colors.white),
          const SizedBox(width: kSpacingSmall),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(kSpacingSmall),
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

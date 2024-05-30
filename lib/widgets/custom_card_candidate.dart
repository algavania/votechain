import 'package:flutter/material.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/utils/extensions.dart';
import 'package:votechain/core/styles.dart';

class CustomCardCandidate extends StatelessWidget {
  const CustomCardCandidate(
      {super.key,
      required this.image,
      required this.name,
      required this.subvicename});

  final ImageProvider image;
  final String name;
  final String subvicename;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Styles.bigPadding),
      padding: const EdgeInsets.all(Styles.defaultPadding),
      decoration: BoxDecoration(
        color: ColorValues.info20,
        borderRadius: BorderRadius.circular(Styles.defaultBorder),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        _buildImageCandidate(),
        const SizedBox(width: Styles.defaultSpacing),
        _buildTextCandidate(context),
      ]),
    );
  }

  Widget _buildImageCandidate() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTextCandidate(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pasangan Calon',
          style: context.textTheme.bodySmall,
        ),
        Text(
          name,
          style: context.textTheme.titleMedium,
        ),
        Text(
          subvicename,
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(height: Styles.defaultSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Selengkapnya',
              style: context.textTheme.bodySmall,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/data/models/candidate_model.dart';
import 'package:votechain/database/data_helper.dart';
import 'package:votechain/utils/extensions.dart';
import 'package:votechain/widgets/custom_button.dart';

@RoutePage()
class VotePage extends StatefulWidget {
  const VotePage({super.key});

  @override
  State<VotePage> createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voting'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Styles.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopIntroWidget(),
              const SizedBox(
                height: Styles.bigSpacing,
              ),
              _buildCandidateSectionWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCandidateSectionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Calon Presiden 2024',
          style: context.textTheme.titleMedium,
        ),
        Text('${DataHelper.candidates.length} calon kandidat'),
        const SizedBox(
          height: Styles.defaultSpacing,
        ),
        _buildCandidateListWidget(),
      ],
    );
  }

  Widget _buildCandidateListWidget() {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, i) =>
            _buildCandidateItemWidget(DataHelper.candidates[i], i),
        separatorBuilder: (_, __) => const SizedBox(
              height: Styles.defaultSpacing,
            ),
        itemCount: DataHelper.candidates.length);
  }

  Widget _buildCandidateItemWidget(CandidateModel candidate, int i) {
    return Container(
      decoration: BoxDecoration(
        color: ColorValues.primary10,
        borderRadius: BorderRadius.circular(Styles.defaultBorder),
      ),
      padding: const EdgeInsets.all(Styles.defaultPadding),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Styles.defaultBorder),
            child: CachedNetworkImage(
              imageUrl: candidate.imageUrl,
              height: 27.h,
              width: 100.w,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: Styles.defaultSpacing,
          ),
          Text(
            'Pasangan calon ${i + 1}\n${candidate.leadName} - ${candidate.viceName}',
            textAlign: TextAlign.center,
            style: context.textTheme.titleMedium
                .copyWith(color: ColorValues.primary60),
          ),
          const SizedBox(
            height: Styles.defaultSpacing,
          ),
          Row(
            children: [
              CustomButton(
                isOutlined: true,
                text: 'Detail',
                onPressed: () {},
              ),
              const SizedBox(
                width: Styles.defaultSpacing,
              ),
              Expanded(
                  child: CustomButton(
                text: 'Vote',
                onPressed: () {},
              ))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTopIntroWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selamat Datang!',
          style: context.textTheme.titleLarge,
        ),
        const Text('Gunakan hak suaramu dengan bijak.'),
      ],
    );
  }
}

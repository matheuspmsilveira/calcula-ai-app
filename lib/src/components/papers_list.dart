import 'package:flutter/material.dart';
import 'package:calcula_ai/src/components/paper_card.dart';
import 'package:calcula_ai/src/models/paper_model.dart';

class PapersList extends StatelessWidget {
  final List<PaperModel> papers;

  const PapersList({
    Key? key,
    required this.papers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            bottom: 90.0,
          ),
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 8.0),
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: papers.length,
            itemBuilder: (context, index) {
              var paper = papers[index];
              return PaperCard(paper: paper);
            },
          ),
        ),
      ],
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:calcula_ai/src/components/paper_form.dart';
import 'package:calcula_ai/src/models/paper_model.dart';

class NewPaperModal extends StatelessWidget {
  final PaperModel? paper;

  const NewPaperModal({
    Key? key,
    this.paper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  paper != null ? 'Editar Papel' : 'Novo Papel',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const FaIcon(
                    FontAwesomeIcons.x,
                    size: 16,
                  ),
                ),
              ],
            ),
            PaperForm(paper: paper),
          ],
        ),
      ),
    );
  }
}

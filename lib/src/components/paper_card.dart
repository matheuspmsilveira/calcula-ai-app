// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:calcula_ai/main.dart';
import 'package:calcula_ai/src/components/new_paper_modal.dart';
import 'package:calcula_ai/src/providers/papers_provider.dart';
import 'package:flutter/material.dart';
import 'package:calcula_ai/src/models/paper_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaperCard extends StatelessWidget {
  final PaperModel paper;

  const PaperCard({
    Key? key,
    required this.paper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black38, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'ID: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(paper.id),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Nome: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(paper.name),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Tamanho: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${paper.width}x${paper.height}'),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Gramatura: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${NumberFormat("###,##0.00", "pt_BR").format(paper.grammage)} gr',
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Valor: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'R\$${NumberFormat("###,##0.00", "pt_BR").format(paper.value)}'),
                ],
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                icon: const FaIcon(
                  FontAwesomeIcons.pencil,
                  color: Colors.deepPurple,
                  size: 16,
                ),
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return NewPaperModal(paper: paper);
                    },
                  );
                },
              ),
              Consumer<PapersProvider>(
                  builder: (context, papersProvider, child) {
                return IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.trash,
                    color: Colors.red,
                    size: 16,
                  ),
                  onPressed: () {
                    try {
                      papersProvider.deletePaper(paper.id).then(
                            (value) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Papel deletado com sucesso'),
                              ),
                            ),
                          );
                    } catch (e) {
                      scaffoldKey.currentState!.showSnackBar(
                        const SnackBar(
                          content: Text('Erro ao deletar papel'),
                        ),
                      );
                    }
                  },
                );
              })
            ],
          )
        ],
      ),
    );
  }
}

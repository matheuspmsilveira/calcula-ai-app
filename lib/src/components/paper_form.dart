// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:calcula_ai/src/models/paper_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:calcula_ai/main.dart';
import 'package:calcula_ai/src/models/paper_without_id_modal.dart';
import 'package:calcula_ai/src/providers/papers_provider.dart';

class PaperForm extends StatefulWidget {
  final PaperModel? paper;

  const PaperForm({
    Key? key,
    this.paper,
  }) : super(key: key);

  @override
  PaperFormState createState() {
    return PaperFormState();
  }
}

class PaperFormState extends State<PaperForm> {
  final _formKey = GlobalKey<FormState>();
  final paperNameController = TextEditingController();
  final paperWidthController = TextEditingController();
  final paperHeigthController = TextEditingController();
  final paperGrammageController = TextEditingController();
  final paperPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.paper != null) {
      paperNameController.text = widget.paper!.name;
      paperWidthController.text = widget.paper!.width.toString();
      paperHeigthController.text = widget.paper!.height.toString();
      paperGrammageController.text = widget.paper!.grammage.toString();
      paperPriceController.text = widget.paper!.value.toString();
    }
  }

  @override
  void dispose() {
    paperNameController.dispose();
    paperWidthController.dispose();
    paperHeigthController.dispose();
    paperGrammageController.dispose();
    paperPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PapersProvider>(builder: (context, papersProvider, child) {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Escreva o nome do papel',
                labelText: 'Nome',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor digite algo';
                }
                return null;
              },
              controller: paperNameController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Escreva a largura do papel',
                labelText: 'Largura (mm)',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor digite algo';
                }
                return null;
              },
              controller: paperWidthController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Escreva a altura do papel',
                labelText: 'Altura (mm)',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor digite algo';
                }
                return null;
              },
              controller: paperHeigthController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Escreva gramatura do papel',
                labelText: 'Gramatura (gr)',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*(?:[\.\,]\d{0,2})?$'),
                )
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor digite algo';
                }
                return null;
              },
              controller: paperGrammageController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Escreva o valor do papel',
                labelText: 'Valor (un)',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*(?:[\.\,]\d{0,2})?$'),
                )
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor digite algo';
                }
                return null;
              },
              controller: paperPriceController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      if (widget.paper != null) {
                        var paper = PaperModel(
                          id: widget.paper!.id,
                          name: paperNameController.text,
                          width: int.parse(paperWidthController.text),
                          height: int.parse(paperHeigthController.text),
                          grammage: double.parse(
                            NumberFormat("###.0#", "pt_BR")
                                .parse(paperGrammageController.text)
                                .toString(),
                          ),
                          value: double.parse(
                            NumberFormat("###.0#", "pt_BR")
                                .parse(paperPriceController.text)
                                .toString(),
                          ),
                        );

                        await papersProvider.editPaper(widget.paper!.id, paper);

                        scaffoldKey.currentState!.showSnackBar(
                          const SnackBar(
                            content: Text('Papel editado com sucesso'),
                          ),
                        );
                      } else {
                        var paper = PaperWithoutIdModel(
                          name: paperNameController.text,
                          width: int.parse(paperWidthController.text),
                          height: int.parse(paperHeigthController.text),
                          grammage: double.parse(paperGrammageController.text),
                          value: double.parse(paperPriceController.text),
                        );

                        await papersProvider.createPaper(paper);

                        scaffoldKey.currentState!.showSnackBar(
                          const SnackBar(
                            content: Text('Papel salvo com sucesso'),
                          ),
                        );
                      }
                    } catch (e) {
                      if (widget.paper != null) {
                        scaffoldKey.currentState!.showSnackBar(
                          const SnackBar(content: Text('Erro ao editar papel')),
                        );
                      } else {
                        scaffoldKey.currentState!.showSnackBar(
                          const SnackBar(content: Text('Erro ao criar papel')),
                        );
                      }
                    }
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.pop(context);
                    });
                  }
                },
                child: Text(widget.paper != null ? 'Editar' : 'Criar'),
              ),
            ),
          ],
        ),
      );
    });
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:calcula_ai/src/models/paper_model.dart';

class Calculator extends StatefulWidget {
  final List<PaperModel> papers;

  const Calculator({
    Key? key,
    required this.papers,
  }) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  late PaperModel _selectedPaper;
  int _maxObjectsPerSheet = 0;
  int _sheetsRequired = 0;
  double _totalCost = 0;
  bool _isCalculated = false;
  final _formKey = GlobalKey<FormState>();
  final widthController = TextEditingController();
  final heigthController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final bloodLettingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedPaper = widget.papers.first;
    });
  }

  @override
  void dispose() {
    widthController.dispose();
    heigthController.dispose();
    quantityController.dispose();
    priceController.dispose();
    bloodLettingController.dispose();
    setState(() {
      _isCalculated = false;
    });
    super.dispose();
  }

  void reset() {
    widthController.text = '';
    heigthController.text = '';
    quantityController.text = '';
    priceController.text = '';
    bloodLettingController.text = '';
    setState(() {
      _selectedPaper = widget.papers.first;
      _isCalculated = false;
    });
  }

  void handleSubmit(
    int width,
    int height,
    int quantity,
    double price,
    double bloodLetting,
  ) {
    final provisionalWidth =
        ((_selectedPaper.width - 2 * bloodLetting) / width).floor();
    final provisionalHeight =
        ((_selectedPaper.height - 2 * bloodLetting) / height).floor();
    // Calcula o total de objetos por folha
    final totalObjectsPerSheet = provisionalWidth * provisionalHeight;

    // Calcula largura provisória alternativa
    final altProvisionalWidth =
        ((_selectedPaper.width - 2 * bloodLetting) / height).floor();

    // Calcula a altura provisória alternativa
    final altProvisionalHeight =
        ((_selectedPaper.height - 2 * bloodLetting) / width).floor();

    // Calcula o total de objetos por folha para a alternativa
    final altTotalObjectsPerSheet = altProvisionalWidth * altProvisionalHeight;

    // Escolhe o maior total de objetos por folha
    final maxObjectsPerSheet =
        max(totalObjectsPerSheet, altTotalObjectsPerSheet).toInt();

    // Calcula a quantidade de folhas necessárias
    final sheetsRequired = (quantity / maxObjectsPerSheet).ceil();

    // Calcula o custo total
    final totalCost = (price + _selectedPaper.value) * sheetsRequired;

    setState(() {
      _maxObjectsPerSheet = maxObjectsPerSheet;
      _sheetsRequired = sheetsRequired;
      _totalCost = totalCost;
      _isCalculated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                controller: widthController,
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
                controller: heigthController,
              ),
              const SizedBox(height: 16.0),
              const Text('Selecione um papel:'),
              DropdownMenu<PaperModel>(
                initialSelection: widget.papers.first,
                onSelected: (PaperModel? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    _selectedPaper = value!;
                  });
                },
                dropdownMenuEntries:
                    widget.papers.map<DropdownMenuEntry<PaperModel>>(
                  (PaperModel paper) {
                    return DropdownMenuEntry<PaperModel>(
                      value: paper,
                      label: paper.name,
                    );
                  },
                ).toList(),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Escreva quantidade de papeis',
                  labelText: 'Quantidade (un)',
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
                controller: quantityController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Escreva o custo da página',
                  labelText: 'Custo da página',
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
                controller: priceController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Escreva a sangria',
                  labelText: 'Sangria',
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
                controller: bloodLettingController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          handleSubmit(
                            int.parse(widthController.text),
                            int.parse(heigthController.text),
                            int.parse(quantityController.text),
                            double.parse(priceController.text),
                            double.parse(bloodLettingController.text),
                          );
                        }
                      },
                      child: const Text('Calcular'),
                    ),
                    const SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        reset();
                      },
                      child: const Text('Limpar'),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _isCalculated,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Quantidade de adesivo por folha:'),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        border: Border.all(
                          color: const Color(0xFFD1D5DB),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      width: screenWidth,
                      child: Text(_maxObjectsPerSheet.toString()),
                    ),
                    const Text('Quantidade de folhas:'),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        border: Border.all(
                          color: const Color(0xFFD1D5DB),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      width: screenWidth,
                      child: Text(_sheetsRequired.toString()),
                    ),
                    const Text('Custo total:'),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        border: Border.all(
                          color: const Color(0xFFD1D5DB),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      width: screenWidth,
                      child: Text(
                        'R\$ ${NumberFormat("###,##0.00", "pt_BR").format(_totalCost / 100)}',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

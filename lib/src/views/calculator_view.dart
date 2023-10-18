import 'package:calcula_ai/src/components/calculator.dart';
import 'package:calcula_ai/src/providers/papers_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<PapersProvider>(context, listen: false).fetchPapers().then(
              (value) => {
                setState(
                  () {
                    _isLoading = false;
                  },
                )
              },
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Consumer<PapersProvider>(
            builder: (context, papersProvider, child) =>
                Calculator(papers: papersProvider.papers),
          );
  }
}

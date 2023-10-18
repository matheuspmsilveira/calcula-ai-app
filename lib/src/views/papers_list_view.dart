import 'package:calcula_ai/src/components/papers_list.dart';
import 'package:calcula_ai/src/providers/papers_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PapersListView extends StatefulWidget {
  const PapersListView({super.key});

  @override
  State<PapersListView> createState() => _PapersListViewState();
}

class _PapersListViewState extends State<PapersListView> {
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
                PapersList(papers: papersProvider.papers),
          );
  }
}

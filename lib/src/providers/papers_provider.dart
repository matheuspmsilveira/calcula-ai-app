import 'dart:collection';

import 'package:calcula_ai/src/models/paper_model.dart';
import 'package:calcula_ai/src/models/paper_without_id_modal.dart';
import 'package:calcula_ai/src/services/network/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class PapersProvider extends ChangeNotifier {
  final restClient = RestClient(
    Dio(BaseOptions(contentType: 'application/json')),
  );

  List<PaperModel> _papers = [];

  UnmodifiableListView<PaperModel> get papers => UnmodifiableListView(_papers);

  Future<void> fetchPapers() async {
    try {
      final List<PaperModel> loadedPapers = await restClient.getPapers();
      _papers = loadedPapers;
      notifyListeners();
    } catch (e, s) {
      Logger().e(
        'Erro no fetch dos papeis -> PapersProvider',
        error: e,
        stackTrace: s,
      );
    }
  }

  Future<void> createPaper(PaperWithoutIdModel paper) async {
    try {
      await restClient.createPaper(paper);
      await fetchPapers();
      notifyListeners();
    } catch (e, s) {
      Logger().e(
        'Erro ao criar papel -> PapersProvider',
        error: e,
        stackTrace: s,
      );
    }
  }

  Future<void> deletePaper(String id) async {
    try {
      await restClient.deletePaper(id);
      await fetchPapers();
      notifyListeners();
    } catch (e, s) {
      Logger().e(
        'Erro ao deletar papel -> PapersProvider',
        error: e,
        stackTrace: s,
      );
    }
  }

  Future<void> editPaper(String id, PaperModel paper) async {
    try {
      await restClient.updatePaper(id, paper);
      await fetchPapers();
      notifyListeners();
    } catch (e, s) {
      Logger().e(
        'Erro ao editar papel -> PapersProvider',
        error: e,
        stackTrace: s,
      );
    }
  }
}

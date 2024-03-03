import 'package:flutter/material.dart';
import 'package:movies/data/http/exceptions.dart';
import 'package:movies/data/models/produto_model.dart';
import 'package:movies/data/repositories/produto_repository.dart';

class ProdutoStore {
  final IProdutoRepository repository;

  //Variavel reativa para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  //Variavel reativa para o State
  final ValueNotifier<List<ProdutoModel>> state =
      ValueNotifier<List<ProdutoModel>>([]);

  //Variavel reativa para erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ProdutoStore({required this.repository});

  Future getProdutos() async {
    isLoading.value = true;

    try {
      final result = await repository.getProdutos();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}

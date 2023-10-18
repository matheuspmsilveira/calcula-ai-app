import 'package:calcula_ai/src/components/new_paper_modal.dart';
import 'package:calcula_ai/src/providers/home_view_provider.dart';
import 'package:calcula_ai/src/views/calculator_view.dart';
import 'package:calcula_ai/src/views/papers_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewProvider>(
      builder: (context, homeViewProvider, child) => SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'calcula.AI',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.deepPurple,
            centerTitle: true,
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.deepPurple,
            elevation: 50.0,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.note),
                label: 'Papeis',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calculate),
                label: 'Calculadora',
              ),
            ],
            currentIndex: homeViewProvider.currentIndex,
            selectedItemColor: Colors.white,
            onTap: (int newindex) {
              homeViewProvider.changeTab(newindex, context);
            },
          ),
          body: IndexedStack(
            index: homeViewProvider.currentIndex,
            children: const [
              PapersListView(),
              CalculatorView(),
            ],
          ),
          floatingActionButton: homeViewProvider.currentIndex == 0
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return const NewPaperModal();
                          },
                        );
                      },
                      isExtended: true,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: Colors.deepPurple,
                      label: const Text(
                        'Novo Papel',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                )
              : Container(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}

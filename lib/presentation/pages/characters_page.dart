import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../controllers/characters_controller.dart';
import '../widgets/character_card.dart';
import '../widgets/error_view.dart';
import '../widgets/search_field.dart';
import '../widgets/characters_app_bar.dart';
import '../widgets/characters_title_section.dart';
import '../widgets/no_results_found.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  final CharactersController controller = Modular.get<CharactersController>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.loadCharacters();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_scrollController.position.outOfRange) {
      controller.loadCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CharactersAppBar(),
      body: RefreshIndicator(
        onRefresh: () => controller.loadCharacters(refresh: true),
        color: Colors.black,
        child: Column(
          children: [
            SearchField(
              controller: _searchController,
              onChanged: controller.setSearchQuery,
            ),
            Expanded(
              child: Observer(
                builder: (_) {
                  if (controller.state == CharactersState.initial) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  }

                  if (controller.state == CharactersState.error &&
                      controller.characters.isEmpty) {
                    return ErrorView(
                      message: controller.errorMessage,
                      onRetry: controller.retryLoading,
                    );
                  }

                  return Column(
                    children: [
                      CharactersTitleSection(
                        searchQuery: controller.searchQuery,
                      ),
                      Expanded(
                        child:
                            controller.characters.isEmpty &&
                                    controller.searchQuery.isNotEmpty
                                ? NoResultsFound(
                                  searchQuery: controller.searchQuery,
                                )
                                : GridView.builder(
                                  controller: _scrollController,
                                  padding: const EdgeInsets.all(16),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16,
                                        childAspectRatio: 1.0,
                                      ),
                                  itemCount:
                                      controller.characters.length +
                                      (controller.state ==
                                                  CharactersState.loading &&
                                              controller.searchQuery.isEmpty
                                          ? 2
                                          : 0),
                                  itemBuilder: (context, index) {
                                    if (index >= controller.characters.length) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    }

                                    final character =
                                        controller.characters[index];
                                    return CharacterCard(
                                      character: character,
                                      onTap:
                                          () => Modular.to.pushNamed(
                                            '/character/${character.id}',
                                            arguments: character,
                                          ),
                                    );
                                  },
                                ),
                      ),
                      if (controller.state == CharactersState.error &&
                          controller.characters.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Erro ao carregar mais pokémons: ${controller.errorMessage}',
                            style: TextStyle(color: Colors.grey[800]),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

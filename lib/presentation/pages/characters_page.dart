import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../controllers/characters_controller.dart';
import '../widgets/character_card.dart';
import '../widgets/error_view.dart';

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
    print('CharactersPage - initState');
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
      print('CharactersPage - Carregando mais pokémons');
      controller.loadCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/poke-ball.png',
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 8),
            const Text(
              'POKÉDEX',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.loadCharacters(refresh: true),
        color: Colors.black,
        child: Column(
          children: [
            // Campo de pesquisa fixo no topo
            _buildSearchField(),

            // Conteúdo principal
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: Observer(
                          builder:
                              (_) => Text(
                                controller.searchQuery.isNotEmpty
                                    ? 'RESULTADOS PARA "${controller.searchQuery.toUpperCase()}"'
                                    : 'POKÉMON COLLECTION',
                                style: const TextStyle(
                                  color: Color(0xFF303943),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                        ),
                      ),
                      Expanded(
                        child:
                            controller.characters.isEmpty &&
                                    controller.searchQuery.isNotEmpty
                                ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.search_off,
                                        size: 80,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Nenhum Pokémon encontrado para "${controller.searchQuery}"',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
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

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          border: const Border(
            bottom: BorderSide(color: Colors.black, width: 1.0),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 26, color: Colors.black.withAlpha(153)),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Pokémon',
                  hintStyle: TextStyle(
                    color: Colors.black.withAlpha(102),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  isDense: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                style: const TextStyle(color: Colors.black87, fontSize: 16),
                onChanged: (value) {
                  controller.setSearchQuery(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

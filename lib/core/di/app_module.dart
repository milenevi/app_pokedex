import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../data/datasources/pokemon_api_datasource.dart';
import '../../data/repositories/character_repository_impl.dart';
import '../../domain/repositories/character_repository.dart';
import '../../domain/usecases/get_character_by_id.dart';
import '../../domain/usecases/get_characters.dart';
import '../../presentation/controllers/character_detail_controller.dart';
import '../../presentation/controllers/characters_controller.dart';
import '../../presentation/pages/character_detail_page.dart';
import '../../presentation/pages/characters_page.dart';
import '../../presentation/pages/splash_page.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    // Core
    i.add<Dio>(
      () => Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
        ),
      ),
    );

    // Data sources
    i.add<PokemonApiDatasource>(
      () => PokemonApiDatasourceImpl(dio: i.get<Dio>()),
    );

    // Repositories
    i.add<CharacterRepository>(
      () => CharacterRepositoryImpl(datasource: i.get<PokemonApiDatasource>()),
    );

    // Use cases
    i.add<GetCharacters>(() => GetCharacters(i.get<CharacterRepository>()));
    i.add<GetCharacterById>(
      () => GetCharacterById(i.get<CharacterRepository>()),
    );

    // Controllers
    i.addSingleton(() => CharactersController(i.get<GetCharacters>()));
    i.add(() => CharacterDetailController(i.get<GetCharacterById>()));
  }

  @override
  void routes(RouteManager r) {
    r.child('/splash', child: (context) => const SplashPage());
    r.child('/', child: (context) => const CharactersPage());
    r.child(
      '/character/:id',
      child:
          (context) => CharacterDetailPage(
            characterId: int.parse(r.args.params['id']),
            character: r.args.data,
          ),
    );
  }
}

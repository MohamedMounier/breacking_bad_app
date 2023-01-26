import 'package:breakingbad_app/data/models/characters_model.dart';
import 'package:breakingbad_app/data/repository/character_repository.dart';
import 'package:breakingbad_app/presentation/screens/character_details_screen.dart';
import 'package:breakingbad_app/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:breakingbad_app/business_logic/cubit/cubit_character.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/strings.dart';
import 'data/api/api_service.dart';

class AppRouter{
  late final CharacterRepository characterRepository;
  late final CharacterCubit characterCubit;
  AppRouter(){
characterRepository=CharacterRepository(ApiServices());
characterCubit=CharacterCubit(characterRepository);
  }
Route? generateRoute(RouteSettings settings){
  switch(settings.name){
    case characterScreen:
      return MaterialPageRoute(builder: (_)=>BlocProvider(
          create: (BuildContext context)=>characterCubit,
        child: CharactersScreen(),

      ),);

    case characterDetailsScreen:
      final character=settings.arguments as CharacterModel;
      return MaterialPageRoute(builder: (_)=>BlocProvider(
        create: (context) => CharacterCubit(characterRepository),
          child: CharacterDetailsScreen(characterModel: character,)));
  }
}
}
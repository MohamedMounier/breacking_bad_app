import 'package:breakingbad_app/data/models/characters_model.dart';
import 'package:breakingbad_app/data/repository/character_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakingbad_app/business_logic/cubit/cubit_states.dart';

class CharacterCubit extends Cubit<CharactersStates>{

 final CharacterRepository? characterRepository;
   List<CharacterModel> characters=[];
  CharacterCubit(this.characterRepository) : super(CharacterInitial());

 List<CharacterModel> ?fetchCharactersInCubit(){
   characterRepository!.fetchCharacters().then((characters) => {
     emit(CharacterLoaded(characters)),
     this.characters=characters
   });
   return characters;
 }
 void fetchQuotesInCubit(String charName){
   characterRepository!.fetchQuotes(charName).then((quotes) => {
     emit(QuotesLoaded(quotes))
   });
 }
}
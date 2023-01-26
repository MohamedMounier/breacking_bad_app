import 'package:breakingbad_app/data/models/char_quote.dart';
import 'package:breakingbad_app/data/models/characters_model.dart';

abstract class CharactersStates{}
class CharacterInitial extends CharactersStates{}
class CharacterLoaded extends CharactersStates{
  final List<CharacterModel> listOfChars;

  CharacterLoaded(this.listOfChars);
}
class QuotesLoaded extends CharactersStates{
  final List<Quote> quotes;

  QuotesLoaded(this.quotes);
}
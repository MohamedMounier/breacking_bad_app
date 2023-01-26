import 'package:breakingbad_app/data/api/api_service.dart';
import 'package:breakingbad_app/data/models/char_quote.dart';
import 'package:breakingbad_app/data/models/characters_model.dart';



class CharacterRepository{

final ApiServices apiServices;

  CharacterRepository(this.apiServices);

  Future<List<CharacterModel>> fetchCharacters()async{
final characters=await apiServices.getAllCharacters();
List<CharacterModel> allChars=[];
characters.forEach((element) { 
  allChars.add(CharacterModel.fromJson(element));
  print('allChars are $allChars');
});
var allCharsTry= characters.map((character) =>CharacterModel.fromJson(character)).toList();
print('all characters try is $allCharsTry');
return allChars;
  }
Future<List<Quote>> fetchQuotes(String charName)async{
    final quoteData=await ApiServices().getQuotes(charName);
  var quotes= quoteData.map((OneQuote) => Quote.fromJson(OneQuote)).toList();
  print('all characters try is $quotes');
  return quotes;
}
}
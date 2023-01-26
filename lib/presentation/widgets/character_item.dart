import 'package:breakingbad_app/constants/mycolors.dart';
import 'package:breakingbad_app/constants/strings.dart';
import 'package:breakingbad_app/data/models/characters_model.dart';
import 'package:flutter/material.dart';
class CharacterItem extends StatelessWidget {
  final CharacterModel character;

 const CharacterItem(this.character);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.only(start: 4,bottom: 4,top: 4,end: 4),
      decoration: BoxDecoration(
          color: MyColors.myWhite,
          borderRadius: BorderRadius.circular(8)
      ),
      child: InkWell(
        onTap: ()=>Navigator.pushNamed(context, characterDetailsScreen,arguments: character),
        child: GridTile(
          child: Hero(
            tag: character.charId!,
            child: Container(
                color: MyColors.myGrey,
                child: character.image!.isNotEmpty?
                FadeInImage.assetNetwork(placeholder: 'assets/images/loading.gif', image: character.image!,fit: BoxFit.cover,):CircularProgressIndicator()

            ),
          ),
          footer: Container(
            height: 30,
            color: Colors.black54,
            child: Center(
              child: Text('${character.name}',style:
              TextStyle(color: MyColors.myWhite),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breakingbad_app/business_logic/cubit/cubit_character.dart';
import 'package:breakingbad_app/business_logic/cubit/cubit_states.dart';
import 'package:breakingbad_app/constants/mycolors.dart';
import 'package:breakingbad_app/data/models/characters_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharacterModel characterModel;

  const CharacterDetailsScreen({Key? key, required this.characterModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharacterCubit>(context).fetchQuotesInCubit(characterModel.name!);
    double heightMedia = MediaQuery.of(context).size.height;
    double widthMedia = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildAppBarSliver(heightMedia),
          SliverList(delegate: SliverChildListDelegate(
            [
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCharInfo('Job : ',characterModel.jobs!.join(' / ')),
                    buildDivider(widthMedia*.8),
                    buildCharInfo('Appeared in : ',characterModel.categoryForSeries!),
                    buildDivider(widthMedia*.67),
                    characterModel.appearanceInSeason!.isEmpty?Container():
                    buildCharInfo('Season : ',characterModel.appearanceInSeason!.join(' / ')),
                    characterModel.appearanceInSeason!.isEmpty?Container():
                    buildDivider(widthMedia*.73),
                    buildCharInfo('Status : ',characterModel.statusIfDeadOrAlive!),
                    buildDivider(widthMedia*.75),
                    characterModel.betterCallSaulAppearance!.isEmpty?Container():
                    buildCharInfo('Better Call Saul Seasons : ',characterModel.betterCallSaulAppearance!.join(' / ')),
                    characterModel.betterCallSaulAppearance!.isEmpty?Container():
                    buildDivider(widthMedia*.6),
                    buildCharInfo('Actor/Actress : ',characterModel.actorName!),
                    buildDivider(widthMedia*.6),
                    SizedBox(height: 20,),
                    BlocBuilder<CharacterCubit,CharactersStates>(
                        builder: (context, state) {
                          if(state is QuotesLoaded){
                            return displayRandomQuoteOrEmpty(state);
                          }else{}
                         return Center(child: CircularProgressIndicator());

                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: heightMedia-heightMedia*.4,)
            ]
          )),
        ],
      ),
    );
  }

  Widget buildAppBarSliver(heightMedia) {
    return SliverAppBar(
      backgroundColor: MyColors.myGrey,
      expandedHeight: heightMedia * .82,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          '${characterModel.nickName}',
          style: TextStyle(color: MyColors.myWhite),
        ),
        background: Image.network(
          '${characterModel.image}',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

 Widget buildCharInfo(String title,String value) {
    return RichText(
      maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text:TextSpan(
          children: [
            TextSpan(
                text: title,
              style: TextStyle(
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18
              )
            ),
            TextSpan(
                text: value,
                style: TextStyle(
                    color: MyColors.myWhite,
                  fontSize: 16
                )
            )
          ]
        )
    );
 }

 Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColors.myYellow,
      thickness: 2,
      // indent is the difference between the end of the divider and the screen side
      endIndent: endIndent,
      height: 30,
    );
 }

  Widget displayRandomQuoteOrEmpty(QuotesLoaded state) {
      var quotes= state.quotes;
      if(quotes.length!=0){
      int randomQuoteIndex= Random().nextInt(quotes.length-1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: MyColors.myWhite,
              shadows: [
                Shadow(
                  blurRadius: 7,
                  offset: Offset(0,0),
                  color: MyColors.myYellow
                ),
              ],
            ),
            child: AnimatedTextKit(
    repeatForever: true,
    animatedTexts: [
    FlickerAnimatedText('${quotes[randomQuoteIndex].quote}'),
    ],
        ),
      ),);
    }else{
        return Container();
      }
  }
}

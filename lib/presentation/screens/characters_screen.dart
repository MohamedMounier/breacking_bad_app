import 'package:breakingbad_app/business_logic/cubit/cubit_character.dart';
import 'package:breakingbad_app/business_logic/cubit/cubit_states.dart';
import 'package:breakingbad_app/constants/mycolors.dart';
import 'package:breakingbad_app/data/models/characters_model.dart';
import 'package:breakingbad_app/presentation/widgets/character_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<CharacterModel>? characters=[];
  List<CharacterModel>? searchedForCharacters=[];
  TextEditingController searchController=TextEditingController();
  bool? isSearching=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CharacterCubit>(context).fetchCharactersInCubit();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: isSearching!?BackButton(color: MyColors.myGrey,):null,
        title: isSearching!?searchText():Text('Characters',
        style: TextStyle(color: MyColors.myGrey),
        ),
        actions: buildAppBarAction(),
        backgroundColor: MyColors.myYellow,),
       body: OfflineBuilder(

           connectivityBuilder: (
               BuildContext context,
               ConnectivityResult connectivity,
               Widget child,
           ){
             final bool connected = connectivity != ConnectivityResult.none;
             if(connected){
               return widgetBuildChars()!;
             }else{
               return buildNoInternetWidget()!;
             }
           },
           child: Center(child: CircularProgressIndicator()),
           ),

          // ,
    );
  }
  Widget? widgetBuildChars(){
    return BlocBuilder<CharacterCubit,CharactersStates>(
        builder: (context, state) {
          if(state is CharacterLoaded){
            characters=state.listOfChars;

            return SingleChildScrollView(
              child: Container(
                color: MyColors.myGrey,
                child: Column(
                  children: [
                    GridView.builder(
                      itemCount: searchController.text.isNotEmpty?searchedForCharacters!.length:characters!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2/3,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                        ),
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {

                          return CharacterItem(isSearching==true&&searchController.text.isNotEmpty?searchedForCharacters![index]:characters![index]);
                          /*
                          this is the working code
                          ((isSearching==false&&searchController.text.isEmpty)||(isSearching==true&&searchController.text.isEmpty))?
                          characters![index]:isSearching==true&&searchController.text.isNotEmpty?searchedForCharacters![index]:searchedForCharacters![index]
                           */
                            //bodyOfChars(index,searchController.text.isEmpty?characters![index]:searchedForCharacters![index]);
                        //  isSearching==true&&searchController.text.isNotEmpty?searchedForCharacters![index]:characters![index]
                        },)
                  ],
                ),
              ),
            );
          }else{
            return Center(
              child: CircularProgressIndicator(

              ),
            );
          }
        },
    );
  }
/*
Widget bodyOfChars(int index,character) {

   final CharacterModel? character;
    return Container(
                          width: double.infinity,
                          margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                          padding: EdgeInsetsDirectional.only(start: 4,bottom: 4,top: 4,end: 4),
                          decoration: BoxDecoration(
                            color: MyColors.myWhite,
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: GridTile(
                              child: Container(
                                color: MyColors.myGrey,
                                child: character!.image!.isNotEmpty?
                                FadeInImage.assetNetwork(placeholder: 'assets/images/loading.gif', image: character.image!,fit: BoxFit.cover,):CircularProgressIndicator()

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
                        );
  }
 */

  Widget ?searchText(){
    return TextFormField(
      controller: searchController,
      cursorColor: MyColors.myGrey,
      style: TextStyle(color: MyColors.myGrey),
      maxLines: 1,
      decoration: InputDecoration(
        hintText: 'Find character',
        border: InputBorder.none,
      ),
      onChanged: (searchedChar){
        addingSearchedItemsToSearchedForList(searchedChar);

      },
    );
  }

  void addingSearchedItemsToSearchedForList(searchedChar) {
    searchedForCharacters=characters!.where((character) => character.name!.toLowerCase().startsWith(searchedChar)).toList();
setState(() {

});
  }
  List<Widget>? buildAppBarAction(){
    if(isSearching!){
      return [
        IconButton(icon: Icon(Icons.clear,color: MyColors.myGrey), onPressed: (){
          //todo:lsa ha3mlha
          clearSearch();
          Navigator.pop(context);
        }),
      ];
    }else{
      return [
        IconButton(icon: Icon(Icons.search,color: MyColors.myGrey,), onPressed: (){
          startSearch();
        })
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove:()=>stopSearching() ));
    setState(() {
      isSearching=true;
    });
  }

  stopSearching() {
    clearSearch();
    setState(() {
      isSearching=false;
    });
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
    });
  }

  Widget? buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text('Can\'t connect to the internet ...Kindly check your internet !',
              style:TextStyle(
                fontSize: 22,
                color: MyColors.myGrey
              ),
              ),
            Image.asset('assets/images/no_internet.jpg')
          ],
        ),
      ),
    );
  }
}

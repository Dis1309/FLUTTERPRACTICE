import 'package:flutter/material.dart';
import 'album1.dart' as album;
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'homevar.dart' as main;
import 'package:provider/provider.dart';
import 'dart:io';

Future<album.Album> fetchAlbum(int i) async{
  final response = await http.get(
  Uri.parse('https://api.imgflip.com/get_memes'));
  // headers: {
  //     HttpHeaders.authorizationHeader: 'Basic your-api-token-here',
  //     "Access-Control-Allow-Origin": "*",
  //   },);
  if(response.statusCode == 200){
    return album.Album.fromJson(jsonDecode(response.body),i);
  } else{
    throw Exception('Failed to load album');
  }
}
class MemePage extends StatefulWidget {
  const MemePage({super.key});

  @override
  State<MemePage> createState() => _MemePageState();
}

class _MemePageState extends State<MemePage> {
  // late Future<album.Album> f;
  // //late=> fetched only when used for first time
  // @override
  
  // void initState(){
  //    super.initState();

  //    f = fetchAlbum(1);
  // }
  @override
  Widget build(BuildContext context) {
  var homestate = context.watch<main.MyHomePageState>();
  var theme = Theme.of(context);
  var style = theme.textTheme.titleLarge!.copyWith(
    color: theme.colorScheme.onPrimary,
  );
  var b = homestate.list;
    return Scaffold(
      appBar: AppBar(
        title: Text("MEMES"),
        backgroundColor: theme.colorScheme.primary,
        centerTitle: true,
      ),
      body:SafeArea(
        child:Center(
          child: ListView(children: [
            if(b.isEmpty) Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Center(child: Card(color: theme.colorScheme.primary,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Add Favourites",
                            style: style,),),),),
            ),
            for(var i in b)
            Meme(i),
          ]),
        ))
    ) ;
  }
}

class Meme extends StatelessWidget{
    Meme(this.i);
   final int i;
  @override
  Widget build(BuildContext context) {
    var homestate = context.watch<main.MyHomePageState>();
  var theme = Theme.of(context);
  var style = theme.textTheme.titleLarge!.copyWith(
    color: theme.colorScheme.onPrimary,
  );
  var b = homestate.list;
    return FutureBuilder<album.Album>(
            future: fetchAlbum(i),
            builder: (context,snapshot){
              if(snapshot.hasData){
                if(snapshot.data!.success == false){
                  return Text('Invalid Favourite');
                }else {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                         border: Border.all(color: Colors.black,width: 5)
                        ),
                        child: Image(image:NetworkImage(snapshot.data!.url),
                        width: snapshot.data!.width,
                        height: snapshot.data!.height,),
                      ),
                      Card(
                        color: theme.colorScheme.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(snapshot.data!.name,
                          style: style,
                          ),
                        ),
                      ),
                    ],
                  ),
                );}
                //here
              }else if(snapshot.hasError){
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            });
  }
}


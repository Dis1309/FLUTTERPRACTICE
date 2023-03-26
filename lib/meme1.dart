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
  late Future<album.Album> f;//late=> fetched only when used for first time
  @override
  
  void initState(){
     super.initState();
     f = fetchAlbum(1);
  }
  @override
  Widget build(BuildContext context) {
  var homestate = context.watch<main.MyHomePageState>();
  var theme = Theme.of(context);
  var b = homestate.list;
    return Scaffold(
      appBar: AppBar(
        title: Text("MEMES"),
        backgroundColor: theme.colorScheme.primary,
        centerTitle: true,
      ),
      body:SafeArea(
        child:Center(
          child: FutureBuilder<album.Album>(
            future: f,
            builder: (context,snapshot){
              if(snapshot.hasData){
                if(snapshot.data!.success == false){
                  return Text('${snapshot.error}');
                }else {
                return Text(snapshot.data!.name);}
              }else if(snapshot.hasError){
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }),
        ))
    ) ;
  }
}




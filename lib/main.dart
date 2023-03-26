import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'meme1.dart';
import 'homevar.dart';
import 'home.dart';
import 'fav.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyHomePageState(),
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo!!',
      theme: ThemeData(
        primarySwatch: Colors.red,      ),
      home: MyHomeState(),
    ),
    );
  }

}




class MyHomeState extends StatefulWidget{
 
  @override
  State<MyHomeState> createState() => MyHomeStateState();
}

class MyHomeStateState extends State<MyHomeState> {
  var si = 2;
  @override
  Widget build(BuildContext context) {
    var homestate = context.watch<MyHomePageState>();
    var counter = homestate.counter;
    Widget page;
    switch (si){
      case 0:
          page = mystate();
          break;
      case 1:
          page = FavouritePage();
          break;
      case 2:
          page = MemePage();
          break;
      default:
          throw UnimplementedError('no widget for $si');
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >=600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home), 
                    label: Text("Home")),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text("Favourite")),
                  NavigationRailDestination(icon: Icon(Icons.emoji_emotions), label: Text('Meme')),
                ],
                selectedIndex: si,
                onDestinationSelected: (value) {
                  setState(() {
                    si = value;
                  });
                },
              ),
            ),
            Expanded(child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ))
          ],
          ),
          
          
        );
      }
    );
  }
}



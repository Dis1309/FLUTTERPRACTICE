import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'homevar.dart';


class FavouritePage extends StatelessWidget {
  const FavouritePage({
    super.key,
  });
 
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var homestate = context.watch<MyHomePageState>();
     final style = theme.textTheme.labelLarge!.copyWith(
       color: theme.colorScheme.primary,
    );
    var b = homestate.list;
    return Scaffold(
      appBar: AppBar(
        title: Text("FAVOURITES"),
        backgroundColor: theme.colorScheme.primary,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("You have ${b.length} favourites:\n",style: style),
                ),
                if(b.isEmpty) Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text('No favourites available',style: style),
                ),
                for(var i in b) Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text("$i",style: style),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

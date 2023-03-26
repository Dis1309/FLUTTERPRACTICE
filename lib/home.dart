import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'homevar.dart';



class mystate extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  var homestate = context.watch<MyHomePageState>();
    var counter = homestate.counter;
    
    IconData icon;
    if(homestate.list.contains(counter)){
    icon = Icons.favorite;
    }else {
    icon = Icons.favorite_border;
    }
        return Scaffold(
          appBar: AppBar(
            title: Text("Flutter home page"),
            centerTitle: true,
          ),
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const BigCard(),
                  Text(
                    '$counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(onPressed: (){homestate.nw();}, icon: Icon(icon), label: Text("Like"))
                ],
              ),
            ),
            floatingActionButton: LayoutBuilder(
              builder: (context,constraints) {
                if(constraints.maxHeight >= 200){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                children:[
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                     child: FloatingActionButton(
                      onPressed: (){homestate. incrementCounter();},
                      tooltip: 'Increment',
                      backgroundColor: Theme.of(context).primaryColor,
                      heroTag: "herotag1",
                      child:  Icon(Icons.add),
                         ),
                             ),
                  ), 
                Align(
                 alignment: Alignment.bottomRight,
                   child: FloatingActionButton(
                   onPressed: (){homestate.decrementCounter();},
                   tooltip: 'Decrement',
                   backgroundColor: Theme.of(context).primaryColor,
                   heroTag: "herotag1",
                   child:  Icon(Icons.remove),
                  
                      ),
                )
                ]
                );
              }else {
                return Container(
                  height: 0,
                  width: 0,
                );
              }
              }
            ),
        );
      }
    
  }

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.labelLarge!.copyWith(
       color: theme.colorScheme.onPrimary,
    );
    return  Card(
      color: theme.colorScheme.secondary,
      child:  Padding(
        padding:  EdgeInsets.all(8.0),
        child:  Text(
          'You have pushed the button this many times:',
          style: style,
        ),
      ),
    );
  }
}
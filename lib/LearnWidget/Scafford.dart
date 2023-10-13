import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
    routes: {
      '\homepage' : (context) => Scaffold(
        appBar: AppBar(
          leading : IconButton(
            icon: Icon(Icons.ac_unit),
            onPressed: () {
              Navigator.pop(context, 'hello viet nam');
            },
          ),
          title: Text('next page'),
        ),
      ),
      '\argument' : (context) => Argument(),
    },
    home : MyWidget(),
  ));
}
class MyWidget extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          bottomNavigationBar: BottomAppBar(
            height: 50,
            child : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child : Icon(Icons.home),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child : Icon(Icons.circle_outlined),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child : Icon(Icons.add),
                  onPressed: () {},
                ),
              ],
            )
          ),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.red,
            title: Text('Scafford'),
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: Icon(Icons.male),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('hello viet nam')));
                  },

                );
              }
            ),
            actions: [Builder(
                builder: (context) {
                  return IconButton(
                    icon: Icon(Icons.female),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                }
            ),
            IconButton(
              onPressed: () async {
                final str = await Navigator.pushNamed(context,'\argument', arguments: 'truyen tham so ');
                print(str);
              },
              icon: Icon(Icons.navigate_next),
              //   onPressed: () {
              //       Navigator.push(context, MaterialPageRoute<void>(
              //         builder: (context) {
              //           return Scaffold(
              //             appBar: AppBar(
              //               title: const Text('Next page'),
              //             ),
              //             body: const Center(
              //               child: Text(
              //                 'This is the next page',
              //                 style: TextStyle(fontSize: 24),
              //               ),
              //             ),
              //           );
              //         },
              //       ));
              //     } ,
              //   icon: Icon(Icons.navigate_next)
            ),
            ],
          ),
          drawer: Drawer(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                } ,
                child : Text('front')
            ),
          ),
          endDrawer: Drawer(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                } ,
                child : Text('late')
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child : Icon(Icons.shape_line),
            onPressed: () {},
          ),
          backgroundColor: Colors.red,
        );

  }

}
class Argument extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('argument'),
        leading: ElevatedButton(
           onPressed: () {
             var str = ModalRoute.of(context)?.settings.arguments;
             print(str);
           }, child: Icon(Icons.ac_unit),
        ),
      ),
    );
  }
  
}
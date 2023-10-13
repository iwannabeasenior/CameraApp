import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:untitled/cameraProject/settings.dart';
import 'QRcode.dart';
import 'camera_page1.dart';
import 'Mylogin.dart';
enum MenuItemButton { item1, item2, item3, item4, item5 }
bool start = true;
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home : SafeArea(
      child : Scaffold(
        body : Login()
      )
    )
  ));
}
class Start extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StartState();

  }

}
class StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
          elevation: 0,
          height: 50,
          child : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

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
                child : Icon(Icons.add_call),
                onPressed: () {},
              ),
            ],
          )
      ),

      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black12.withOpacity(0.05),
        elevation: 0,
        title: Text('Webcam'),
        leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.add_alert_rounded),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }
        ),
        actions: [Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            }
        ),
        PopupMenuButton<MenuItemButton>(
              onSelected: (value) {
                if (value == MenuItemButton.item1) {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Scaffold(
                          body: Center(
                            child: Text('item1 showed', style: TextStyle(
                              color : Colors.red
                            )),
                          ),
                        );
                      }));
                } else if (value == MenuItemButton.item2) {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Scaffold(
                          body: Text('item2 showed'),
                        );
                      }));
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                    value: MenuItemButton.item1,
                    child: Text('1')
                ),
                PopupMenuItem(
                    child: Text('2'),
                    value : MenuItemButton.item2
                )
              ],),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return QRcode();
                }));
          }, icon: Icon(Icons.qr_code)
          )
        ],
      ),
      drawer: Drawer(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            } ,
            child : Text('update')
        ),
      ),

      endDrawer: Drawer(
        child: Column(
          children: [
            Row(
              children: [Expanded(child: ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                     return Scaffold(
                       appBar: AppBar(
                         title: Center(child: Text('Setting')),

                       ),
                       body: Setting(),
                     );
                  }
                ));
              },
                  child: Text('Setting',
                  style : TextStyle(
                    height: 8,

                  )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey
                )
              )
              )],
            ),
            Row(
              children: [Expanded(child:  ElevatedButton(
                onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Scaffold(
                        appBar: AppBar(
                          title: Center(child: Text('About')),
                        ),
                        body: Center(
                          child: Text('This is an app built by Nguyen Trung Thanh - student of Hanoi University'),
                        ),
                      );
                    }));
              },
                  child: Text('About',
                  style: TextStyle(
                    height: 8
                  ),),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white30
                  ))
              )],
            ),
            Row(
              children: [Expanded(child: ElevatedButton(onPressed: () {},
                  child: Text('Privacy', style: TextStyle(height: 8
                  ),),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey
                  ))
              )],
            ),
            Row(
              children: [Expanded(child: ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Scaffold(
                          body : Center(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Center(child: Text('Your account will be banned soon'))
                              ],
                            ),
                          )
                      );
                    }));
              },
                  child: Text('Acount Info',
                  style: TextStyle(
                    height: 8
                  ),),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white30
                  )
              )
              )],
            ),

            Row(
              children: [Expanded(
                child : ElevatedButton(
                  onPressed: () {
                     Navigator.pop(context);
                     Navigator.pop(context);
                  },
                  child : Text('Log out', style: TextStyle(height: 8),),
                  style : ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey
                  )
                )
              )],
            )

          ],
        )
      ),
      floatingActionButton: FloatingActionButton(

        child : Text(start ? 'Start' : 'End'),
        onPressed: () {
          if (start) {
            setState(() {
              start = false;
            });
          }else {
            setState(() {
              start = true;
            });
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      backgroundColor: Colors.black,
      body : Container(
        child : Start1(),
      ),
    );
  }

}
class Start1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    if (start) {
      return Container(
        height: 1000,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/image/anhdep.png'),
              fit: BoxFit.fill),
        ),
        child: Text(''),
    );
    } else {
      return CameraPage();
    }
  }

}



// login
class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
        child: Image.asset('assets/image/login.png'),
        radius: 50,
        backgroundColor: Colors.white
    );
    final user = TextFormField(
      autofocus: true,
      initialValue: '',
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Enter your email',
          contentPadding: EdgeInsets.all(20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))
      ),
    );
    final password = TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Enter your password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
        contentPadding: EdgeInsets.all(20),
      ),
    );
    final login = ElevatedButton(

      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Start();
            }));

      },
      child: Text('Login'),

    );
    final forgetPassword = TextButton(
      onPressed: () {} ,
      child: Text('Forget password'),
    );
    final signIn = TextButton(
      child : Text('Sign in',
        style: TextStyle(
            color : Colors.red
        ),),
      onPressed: () {},
    );
    return Center(
      child: ListView(
        padding: EdgeInsets.only(left : 24, right : 24),
        shrinkWrap: true,
        children: <Widget>[
          logo,
          SizedBox(height: 30,),
          user,
          SizedBox(height: 5,),
          password,
          SizedBox(height: 15,),
          login,
          SizedBox(height: 5,),
          forgetPassword,
          SizedBox(height: 5,),
          signIn


        ],
      ),
    );
  }

}

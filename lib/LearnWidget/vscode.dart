import 'package:flutter/material.dart';
/// qua bài học này rút ra được, trong khi mình click button
/// thì hàm đó sẽ chạy 1 mạch xong hoàn toàn, xong rồi mới đi
/// kiểm tra xem cái nào dc setstate để build lại, mỗi cái chỉ
/// được build lại đúng 1 lần dù có bao nhiêu setstate đi nữa,
/// cha thì luôn được build trước con dù con có setstate trước cha
void main(List<String> args) {
  runApp(MaterialApp(
      home : SafeArea(
          child : Scaffold(
            body : BoMe(),
          )
      )
  ));
}
int conChauCount= 1;int boMeCount = 1, ongBaCount =1;
class OngBa extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return OngBaState();
  }
}
class OngBaState extends State<OngBa> {
  @override
  Widget build(Object context) {
    setState(() {
      ongBaCount ++;
    });
    return Text('Ong ba : $ongBaCount');
  }

}
class BoMe extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return BoMeState();
  }
}
class BoMeState extends State<BoMe> {

  @override
  Widget build(Object context) {
    print('run Bome');
    return Column(children: [Center(
      child : ElevatedButton(
        onPressed: () {
          setState(() {
            boMeCount++;
          });
        } ,
        child : Text('Bo me : $boMeCount'),
      ),),
      ConChau(voidCallback : fool),]
    );
  }
  void fool() {
    setState(() {
      boMeCount++;
      print('hello');
    });
    print('hello sau');
  }
}
class ConChau extends StatefulWidget {
  final VoidCallback? voidCallback;
  const ConChau({required this.voidCallback,  Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return ConChauState();
  }
}
class ConChauState extends State<ConChau> {
  @override
  Widget build(Object context) {
    print('run conchau');
    conChauCount++;
    return Container(
        child : ElevatedButton(
            onPressed : () {
              setState(() {

              });
              widget.voidCallback!();
              print('helloChild');
              // setState(() {
              //   print('$conChauCount');
              // });
              print('set state');
            },
            child : Text('Con Chau : $conChauCount'))

    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'GamePage.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String player1 = '';
  String player2 = '';
  int rounds = 0;
  final nameController = TextEditingController();
  final name2Controller = TextEditingController();
  final roundController = TextEditingController();

  void clear(){
    player1 = '';
    player2 = '';
    rounds = 0;
  }
  void notice(BuildContext context){
    var screen = AlertDialog(
      title: Text('Sorry!'),
      content: Text('Please Enter Your Details'),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('Close!',style: TextStyle(fontFamily: 'Uchen',fontWeight: FontWeight.bold),
        ),
        ),
      ],
    );
    showDialog(context: context, builder: (BuildContext context)=>screen,barrierDismissible: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('Images/hho1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        padding: EdgeInsets.all(50.0),
        children:[
          CircleAvatar(
            child: Image(
              image: AssetImage('Images/rockcircle.png'),
            ),
            radius: 60.0,
            foregroundColor: Colors.black,
          ),
          Card(
              color: Colors.black,
              margin: EdgeInsets.all(20.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Welcome In This Game!',
                    style: TextStyle(
                      fontFamily: 'Uchen',
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
              )
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Please Enter! Player Name & Game Rounds',
                style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 15.0),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
            height: 80.0,
            width: 120.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.yellow,Colors.red,Colors.lightBlueAccent],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
            child: TextField(
              maxLength: 12,
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'First Player',
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                hintText: 'Any Name...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person,color: Colors.black,),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear,color: Colors.black),
                  onPressed: () => nameController.clear(),
                ),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              onChanged: (text){
                player1 = text;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
            height: 80.0,
            width: 120.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red,Colors.yellow,Colors.lightBlueAccent],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
            child: TextField(
              maxLength: 12,
              controller: name2Controller,
              decoration: InputDecoration(
                labelText: 'Second Player',
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                hintText: 'CodexRitik',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person,color: Colors.black),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear,color: Colors.black),
                  onPressed: () => name2Controller.clear(),
                ),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              onChanged: (text){
                player2 = text;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
            height: 80.0,
            width: 120.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightBlueAccent,Colors.yellow,Colors.red],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
            //padding: EdgeInsets.fromLTRB(20.0, 10.0,100.0,10.0),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0,0.0,80.0,0.0),
              child: TextField(
                maxLength: 2,
                controller: roundController,
                decoration: InputDecoration(
                    labelText: 'Round',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    hintText: 'ex:10',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.add,color: Colors.black),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear,color: Colors.black),
                      onPressed: () => roundController.clear(),
                    )
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onChanged: (text){
                  rounds = int.parse(text);
                },

              ),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(80.0, 10.0,80.0,10.0),
            color: Colors.black,
            child: TextButton(
                onPressed: (){
                  setState(() {
                    String p1 = player1;
                    String p2 = player2;
                    int r = rounds;
                    if(p1.isNotEmpty && p2.isNotEmpty && r>0){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Game(p1,p2,r),
                      ),);
                    }
                    else{
                      notice(context);
                    }
                    clear();
                  });
                },
                child: Text('Submit',style: TextStyle(
                  fontFamily: 'Uchen',
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                  color: Colors.blue,
                ),)),
          ),
        ],
      ),
    );
  }
}

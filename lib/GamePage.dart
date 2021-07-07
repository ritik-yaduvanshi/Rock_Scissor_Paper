import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:flutter/widgets.dart';
class Game extends StatefulWidget {
  String player = '';
  String players = '';
  int round = 0;
  Game(String nam,String nam1,int val){
    player = nam;
    players = nam1;
    round = val;
  }

  @override
  _GameState createState() => _GameState(player,players,round);
}

class _GameState extends State<Game> {
  String player1 = '';
  String player2 = '';
  int score1 = 0;
  int score2 = 0;
  int rounds = 0;
  int prev_round =0;
  int totalRound = 0;
  var win1 = 0.0;
  var win2 = 0.0;
  int p = 1;
  int pp = 2;
  int roun = 0;
  String card1 = '';
  String card2 = '';
  int loop = 1;
  List<dynamic> plScore2 = [];
  List<dynamic> plScore = [];
  String GameInfo = 'It is played like this at the same time,two players display one of three symbols a rock, paper, or scissors ,'
      'Rock, paper, scissors is an example of a zero-sum game without perfect information.';
  String Rules = 'A Rock beats Scissors, Scissors beat Paper by cutting it, and Paper beats Rock by covering it.Winner is Awarded by +1 Points and Loser is Awarded by 0 points';
  _GameState(player,players,round){
    player1 = player;
    player2 = players;
    rounds = round;
    prev_round = round;
    totalRound = round;
    card1 = player;
    card2 = players;
  }
  Widget scoreView(){
    var scoreList = ListView.builder(itemCount: plScore.length,itemBuilder: (BuildContext context, int index)
    {return ListTile(
      title: Text('* ${plScore[index]}'),
    );},
    );
    return scoreList;
  }
  Widget score2View(){
    var scoreList = ListView.builder(itemCount: plScore2.length,itemBuilder: (BuildContext context, int index)
    {return ListTile(
      title: Text('* ${plScore2[index]}'),
    );},
    );
    return scoreList;
  }
  static int pic1Value(){
    int res = 0;
    res = Random().nextInt(3)+1;
    return res;
  }
  static int pic2Value(){
    int res = 0;
    res = Random().nextInt(3)+1;
    return res;
  }
  void winRatio(int sc1,int sc2){
    if((sc1 == sc2)&&(sc1>0 && sc2>0)){
      this.win1 = 50.0;
      this.win2 = 50.0;
    }
    else if(sc1==0 && sc2==0){
      this.win1 = 100.0;
      this.win2 = 100.0;
    }
    else{
      this.win1 = (sc1/totalRound)*100;
      this.win2 = (sc2/totalRound)*100;
    }
  }
  void result(int p,int pp){
    if(p == 1){
      if(pp == 2){
        this.score1++;
      }
      else if(pp == 3){
        this.score2++;
      }
    }
    else if(p == 2){
      if(pp == 1){
        this.score2++;
      }
      else if(pp == 3){
        this.score1++;
      }
    }
    else if(p == 3){
      if(pp == 2){
        this.score2++;
      }
      else if(pp == 1){
        this.score1++;
      }
    }
  }
  static void popUp(BuildContext context,String winName,int highScore,String msg){
    var alertDialoge = AlertDialog(
      title: Text('Game Over!'),
      content: Text('Congratulations! $winName\nTotal Score : $highScore\n$msg'),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('Close!',style: TextStyle(fontFamily: 'Uchen',fontWeight: FontWeight.bold),
        ),
        ),
      ],
    );
    showDialog(context: context, builder:(BuildContext context)=>alertDialoge,barrierDismissible: false);
  }
  static void snack(BuildContext context,int r){
    var snackBar = SnackBar(content:Text('You Have $r Move Left!'),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: (){},
      ),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void reset(){
    this.score1 = 0;
    this.score2 = 0;
    this.player1 = 'ex:player1';
    this.player2 = 'ex:player2';

    this.win1 = 0.0;
    this.win2 = 0.0;
    this.p=pic1Value();
    this.pp=pic2Value();
  }
  void clearSummary(){
    this.card1='Empty!';
    this.card2 = 'Empty!';
    this.plScore.clear();
    this.plScore2.clear();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Rock Scissor Paper'),
            titleSpacing: 5.0,
            elevation: 10.0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.lightBlueAccent,Colors.red,Colors.yellow],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  )
              ),
            ),
            bottom: TabBar(
              indicatorColor: Colors.black,
              indicatorWeight: 4,
              tabs: [
                Tab(icon: Icon(Icons.home),text:'Home',),
                Tab(icon: Icon(Icons.score),text:'Score Card',),
                Tab(icon: Icon(Icons.announcement_outlined),text:'About',)
              ],
            ),
          ),
          body: TabBarView(
            children: [
              buildHome(context),
              buildScore(context),
              buildAbout(context),
            ],
          )
      ),
    );
  }
  Widget buildHome(BuildContext context){
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Images/mainHome.jpg'),
              fit: BoxFit.cover,
            )
        ),
        child: ListView(
            children:[ SizedBox(
              height: 15.0,
            ),
              Container(
                margin: EdgeInsets.only(left: 100.0,right: 100.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepOrangeAccent,Colors.white,Colors.lightGreen],
                    begin: Alignment.topLeft,
                    end:Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Expanded(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.grade),
                      Text('Current Score',
                        style: TextStyle(fontFamily:'Satisfy',fontWeight: FontWeight.bold ,fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepOrangeAccent,Colors.yellowAccent,Colors.white,Colors.purple,Colors.lightGreen],
                      begin: Alignment.topLeft,
                      end:Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  margin: EdgeInsets.only(left: 30.0,right: 30.0),
                  child:Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('$player1',
                              style: TextStyle(fontFamily:'OtomanopeeOne',fontWeight: FontWeight.bold ,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('$score1 : $score2',
                              style: TextStyle(fontFamily:'OtomanopeeOne',fontWeight: FontWeight.bold ,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('$player2',
                              style: TextStyle(fontFamily:'OtomanopeeOne',fontWeight: FontWeight.bold ,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 30.0,right: 30.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue,Colors.red,Colors.yellowAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                height: 180.0,
                width: 330.0,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 50.0,
                              child: Image(
                                image: AssetImage('Images/pic$p.png'),
                              ),
                            ),
                          ),
                          Container(
                            child: Text('$player1 : $score1\nWin Rate : ${win1.toStringAsFixed(2)}%',
                              style: TextStyle(fontFamily:'Satisfy',fontWeight: FontWeight.bold ,fontSize: 15.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 50.0,
                              child: Image(
                                image: AssetImage('Images/pic$pp.png'),
                              ),
                            ),
                          ),
                          Container(
                            child: Text('$player2 : $score2\nWin Rate : ${win2.toStringAsFixed(2)}%',
                              style: TextStyle(fontFamily:'Satisfy',fontWeight: FontWeight.bold ,fontSize: 15.0),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.lightBlueAccent,
                    margin: EdgeInsets.fromLTRB(10.0,20.0,60.0,15.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Rounds Left : $rounds',style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                margin: EdgeInsets.only(left:60.0,right: 60.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.lightBlueAccent,Colors.white,Colors.purpleAccent],
                      begin: Alignment.topLeft,
                      end:Alignment.bottomRight,
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('Click Your Move!',
                      style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Niconne',fontSize: 24.0,),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          foregroundColor: Colors.black,
                          radius: 50.0,
                          backgroundImage: AssetImage('Images/spinMove.gif'),
                          child: TextButton(
                            child: Text(''),
                            onPressed: (){
                              setState(() {
                                if(prev_round>=rounds){
                                  p = pic1Value();
                                  prev_round--;
                                }
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('$player1',style: TextStyle(fontFamily:'Satisfy',fontWeight: FontWeight.bold ,fontSize: 25.0,
                              color: Colors.black),),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50.0,
                          foregroundColor: Colors.black,
                          backgroundImage: AssetImage('Images/spinMove.gif'),
                          child: TextButton(
                            child: Text(''),
                            onPressed: (){
                              setState(() {
                                if((prev_round <rounds)&&(rounds >0)){
                                  roun++;
                                  pp = pic2Value();
                                  result(p, pp);
                                  plScore.add('Round $roun : $score1');
                                  plScore2.add('Round $roun : $score2');
                                  winRatio(score1, score2);
                                  rounds--;
                                  snack(context, rounds);
                                }
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('$player2',style: TextStyle(fontFamily:'Satisfy',fontWeight: FontWeight.bold,fontSize: 25.0,
                            color: Colors.black,
                          ),),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              Expanded(
                child: FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: (){
                    setState(() {
                      int diff = 0;
                      String Msg = '';
                      if(rounds==0 && loop>0){
                        if(score1 > score2){
                          diff = score1 - score2;
                          Msg = "You Won By $diff Points!";
                          popUp(context,player1,score1,Msg);
                        }
                        else if(score1 == score2){
                          Msg = 'Match Draw!';
                          popUp(context,'Both',score1, Msg);
                        }
                        else{
                          diff = score2 - score1;
                          Msg = 'You Won By $diff Points!';
                          popUp(context, player2,score2, Msg);
                        }
                        loop--;
                        reset();
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Finish!',
                      style: TextStyle(fontFamily: 'Niconne',fontWeight: FontWeight.bold,fontSize: 20.0,color: Colors.black),
                    ),
                  ),
                ),
              ),
            ]
        )
    );
  }

  Widget buildScore(BuildContext context){
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.red.shade100,Colors.yellowAccent,Colors.blueAccent,Colors.greenAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter
            ),
          ),
          child: ListView(
            children:[ Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.greenAccent,Colors.blueAccent,Colors.yellowAccent,Colors.redAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              margin: EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 110.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(child: Text('Match Summary!',style: TextStyle(
                        fontFamily: 'OtomanopeeOne',
                        fontSize: 18.0,
                      ),)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("$card1",style: TextStyle(
                              fontFamily: 'Niconne',
                              fontSize: 18.0,
                            ),),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("$card2",style: TextStyle(
                              fontFamily: 'Niconne',
                              fontSize: 18.0,
                            ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 120.0,
                          height: 300.0,
                          child: scoreView(),
                        ),
                        Container(
                          width: 120.0,
                          height: 300.0,
                          child: score2View(),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: Colors.green,
                    child: TextButton(
                      child: Text('Clear ScoreCard!',style: TextStyle(
                        fontFamily: 'OtomanopeeOne',
                        fontSize: 15.0,
                        color: Colors.black,
                      ),),
                      onPressed: (){
                        setState(() {
                          if(rounds==0){
                            clearSummary();
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            ],
          )
      ),
    );
  }
  Widget buildAbout(BuildContext context){
    return Scaffold(
      body:ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          Card(
            margin: EdgeInsets.only(left: 40.0,right: 40.0),
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text('About This Game!',style: TextStyle(
                  fontFamily: 'OtomanopeeOne',
                  fontSize: 15.0,
                  color: Colors.white,
                ),),
              ),
            ),
          ),
          ListTile(
            title: Text('1.Game Info',style: TextStyle(fontFamily: 'OtomanopeeOne'),),
            subtitle: Text('This is a Basic Level Game, $GameInfo'),
          ),
          ListTile(
            title: Text('2.Game Rules',style: TextStyle(fontFamily: 'OtomanopeeOne'),),
            subtitle: Text('$Rules.'),
          ),
          ListTile(
            title: Text('3.How To Play',style: TextStyle(fontFamily: 'OtomanopeeOne'),),
            subtitle: Text('There is given two Buttons First is For Player First and Second is For Player Second.Simply You Have to Press Your Move And It will Generate Random Sign till Left Rounds Become Zero.First Player will Press First then Second will Press.'),
          ),
          ListTile(
            title: Text('4.Disclaimer',style: TextStyle(fontFamily: 'OtomanopeeOne'),),
            subtitle: Text('This game does not collect and ask with You for Any Type Of Data Information.Any Kind Of Issue Contact Us on Given Details.'),
          ),
        ],
      ),
    );
  }
}
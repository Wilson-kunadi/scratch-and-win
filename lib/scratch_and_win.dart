import 'dart:math';

import 'package:flutter/material.dart';

class scratch_and_win extends StatefulWidget {
  @override
  _scratch_and_winState createState() => _scratch_and_winState();
}

class _scratch_and_winState extends State<scratch_and_win> {
  // TODO: Initialize images & etc
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage jackpot = AssetImage("images/rupee.png");
  AssetImage zonk = AssetImage("images/sadFace.png");

  int rd, timePressed;
  String msg;
  bool winAlready;

  // Future to pause
  Future resetAfterPause() async {
    await Future.delayed(Duration(seconds: 2));
    this.resetGame();
  }

  // TODO: get an Array
  List<String> gameState;

  // TODO: Define a generateRandom method
  generateLuckyNumber() => this.rd = Random().nextInt(this.gameState.length);

  // TODO: Define a getImage method
  AssetImage getImage(int arrayNumber) {
    switch (this.gameState[arrayNumber]) {
      case 'circle':
        return circle;
        break;
      case 'jackpot':
        return jackpot;
        break;
      case 'zonk':
        return zonk;
        break;
    }
  }

  // TODO: Define playGame method
  playGame(int arrayNumber) async {
    if ((this.timePressed < 5) && (this.winAlready == false)) {
      if (this.gameState[arrayNumber] == "circle") {
        if (arrayNumber == this.rd) {
          setState(() {
            this.gameState[arrayNumber] = "jackpot";
            this.msg = "You Win";
            this.winAlready = true;
            this.resetAfterPause();
          });
        } else {
          setState(() {
            this.gameState[arrayNumber] = "zonk";
            this.timePressed++;
          });
        }
      }
    }

    if (this.timePressed >= 5) {
      setState(() {
        this.msg = "You Lose";
        this.resetAfterPause();
      });
    }
  }

  // TODO: showAll
  showAll() {
    setState(() {
      this.gameState = List.filled(this.gameState.length, "zonk");
      this.gameState[this.rd] = 'jackpot';
    });
  }

  // TODO: resetGame
  resetGame() {
    setState(() {
      this.gameState = List.generate(25, (index) => "circle");
      this.generateLuckyNumber();
      this.msg = "";
      this.winAlready = false;
      this.timePressed = 0;
    });
  }

  // TODO: init state
  @override
  void initState() {
    super.initState();
    this.resetGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scratch & Win"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: this.gameState.length,
              itemBuilder: (context, i) => SizedBox(
                width: 50,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    this.playGame(i);
                  },
                  child: Image(image: this.getImage(i)),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 7.5, 15, 7.5),
            // color: Colors.teal,
            child: Text(
              this.msg,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 7.5, 15, 7.5),
            child: RaisedButton(
              padding: EdgeInsets.all(10),
              color: Colors.teal,
              onPressed: () {
                this.resetGame();
              },
              child: Icon(
                Icons.restore_page,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 7.5, 15, 7.5),
            child: RaisedButton(
              padding: EdgeInsets.all(10),
              color: Colors.teal,
              onPressed: () {
                this.showAll();
              },
              child: Icon(
                Icons.sentiment_dissatisfied,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            color: Colors.black,
            child: Text(
              "LearnCodeonline.in",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

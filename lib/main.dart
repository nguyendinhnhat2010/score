import 'dart:async';
import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  int _score = 0;
  int _counterTime = 5;
  Timer? _timer;
  int _tap = 0;
  List<bool> heart = [];
  int i = 4;
  String stategame = "";

  @override
  void initState() {
    heart = [true, true, true, true, true];
    super.initState();
  }

  void _startTime(){
    _timer?.isActive;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer){
      setState(() {
        if(_counterTime > 0)
        {
          _counterTime--;
        }
        else{
          _timer?.cancel();
          if(10 <= _tap)
          {
            _score = _score + 1;
          }
          else if(_tap < 10)
          {
            heart[i] = false;
            i--;
            if(heart[0] == false)
            {
              stategame = "Game Over!";
            }
          }
        }
      });
    });
  }

  void _resetGame(){
    setState(() {
      _tap = 0;
      _counterTime = 5;
    });
  }

  @override
  _counterTap(){
    setState(() {
      _tap++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Center(
            child: Text("TapTap"),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(stategame.toString(), style: 
              const TextStyle(
                fontSize: 30,
                color: Colors.red,
              ),),
              const Padding(padding: EdgeInsets.only(bottom: 50)),

              Text("Score: " + _score.toString(),
              style: const TextStyle(
                color: Colors.greenAccent,
                fontSize: 20,
              ),),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 15, bottom: 15)),
                    for (var i = 0; i < heart.length; i++)
                  Icon(
                    heart[i]? Icons.favorite : Icons.favorite_border,
                    color: heart[i]? Colors.red[500] : null,
                  ),
                ],
              ),

              Text("Time: " +  _counterTime.toString(),
              style: const TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),),
              const Padding(padding: EdgeInsets.only( bottom: 15)),

              Text("Tap: " + _tap.toString(),
              style: const TextStyle(
                color: Colors.greenAccent,
                fontSize: 24,
              ),),
              const Padding(padding: EdgeInsets.only( bottom: 15)),

              ElevatedButton(
                child: const Text('Tap me'),
                onPressed: _counterTap,
                style: ButtonStyle (
                  backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
                  padding: MaterialStateProperty.all(const EdgeInsets.only(top: 15, bottom: 15, left: 50, right: 50)),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20, right: 10),
                    child: ElevatedButton(
                        child: const Text('Start'),
                        onPressed: _startTime,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.greenAccent),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(
                                  top: 15, bottom: 15, left: 30, right: 30)),
                      )
                    ),
                  ),
                  
                  Container(
                    padding: const EdgeInsets.only(top: 20, left: 10),
                    child: ElevatedButton(
                        child: const Text('Play Again'),
                        onPressed: _resetGame,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.greenAccent),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(
                                  top: 15, bottom: 15, left: 10, right: 10)),
                      )
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

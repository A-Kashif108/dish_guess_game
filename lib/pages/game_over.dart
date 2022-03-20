import 'package:dish_guess_game/pages/game_page.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  final int score;
  const GameOver({Key? key,required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
             Center(
              child: Container(
                  height: h*0.7,
                  width: h*0.7,
                  child: Image(image: AssetImage('assets/gameover.png'))),
            ),
            Text('Your Score : $score',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            SizedBox(height: h*0.05,),
            ElevatedButton(
              onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>const GamePage()));
            },
              child: Text('Play Again',style: TextStyle(fontSize: 20),),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                fixedSize: MaterialStateProperty.all(Size(1.618*77.9, 77.9)),
              ),
            ),
          ],
        ),

      ),
    );
  }
}

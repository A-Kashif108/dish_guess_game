import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dish_guess_game/components/victory_animation.dart';
import 'package:dish_guess_game/pages/game_over.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
    AudioCache audioCache = AudioCache();
    AudioCache audioCache1 = AudioCache();
   String imgUrl ='';
   var l1 = <String>[];
   String dishName ='';
   String result = '';
   int fieldLength =0;
   late int score;
   late int wrongCounter;
   int start =30;
    bool check = false;
    bool hint = false;
    bool hint1 = false;


    late List<String> ch;

   List<TextEditingController> textEditingController = <TextEditingController>[];
  Future<void> getUrl() async{
      var response = await http.get(Uri.https('foodish-api.herokuapp.com','/api' ));
      Map data = jsonDecode(response.body);
      if(response.statusCode==200){
          setState(() {
            imgUrl = data['image'];
            l1 = imgUrl.split('/');
            dishName = l1[4];
            var temp = dishName.split('-');
            if(temp.length>1){
              dishName = temp[0]+temp[1];
            }
          });
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     getUrl();
    // startTimer();
    score=0;
    wrongCounter=0;
  }

  bool checkVowel(String c) {
    if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
      return true;
    }
    return false;
  }
   List<Widget> textFields(double w) {
     List<String> letters = dishName.split('');
     ch =letters;
     fieldLength =letters.length;
     var l1 = <Widget>[];
     List<FocusNode> focusNodes = List<FocusNode>.generate(letters.length, (int index) => FocusNode());
      textEditingController = List<TextEditingController>.generate(letters.length, (int index) => TextEditingController());
     void focusBack(int i){
       if(i<=0){
         return;
       }
       if(checkVowel(letters[i-1])){
         focusBack(i-1);
       }else{
         focusNodes[i-1].requestFocus();
       }
     }
     void focusFront(int i){
       for(int j=i+1;j<letters.length;j++){
         if(!checkVowel(letters[j])){
           focusNodes[j].requestFocus();
           break;
         }
       }
     }

     for (int i = 0; i < letters.length; i++) {
       l1.add(Padding(
         padding:  EdgeInsets.all(w*0.01),
         child: Container(
           height: w>900?50:w*0.05,
           width: w>900?50:w*0.05,

           decoration: BoxDecoration(
             color: Colors.grey.shade200,
             borderRadius: BorderRadius.circular(w*0.009),
             border: Border.all(color: Colors.grey.shade300),
           ),
           child: Center(
             child: hint?checkVowel(letters[i])?Text(letters[i],
               style:  TextStyle(fontSize: w>900?20:w*0.03 ),):
             TextField(
               autofocus: true,
               textAlignVertical: TextAlignVertical.bottom,
               controller: textEditingController[i],
               maxLength: 1,
               focusNode: focusNodes[i],
               onChanged: (value){
                    if(value.isEmpty){
                      if(i!=0) {
                        result=result.substring(0,i);
                          focusBack(i);
                      }else{
                        result='';
                      }
                    }else{
                      textEditingController[i].text = value;
                      if(i+1!=letters.length){
                          focusFront(i);
                      }
                      result = result+value;
                      if(i==letters.length-1){
                        focusNodes[i].unfocus();
                      }
                    }
               },
               style:  TextStyle(fontSize: w>900?20:w*0.03 ),
               textInputAction: TextInputAction.next,
               textAlign: TextAlign.center,
               decoration: const InputDecoration(
                   border: InputBorder.none,
                   counterText: ''
               ),
             ):TextField(
               autofocus: true,
               textAlignVertical: TextAlignVertical.bottom,
               controller: textEditingController[i],
               maxLength: 1,
               focusNode: focusNodes[i],
               onChanged: (value){
                 if(value.isEmpty){
                   if(i!=0) {
                     result=result.substring(0,i);
                     focusNodes[i - 1].requestFocus();
                   }else{
                     result='';
                   }
                 }else{
                   textEditingController[i].text = value;
                   if(i+1!=letters.length){
                     focusNodes[i+1].requestFocus();
                   }
                   result = result+value;
                   if(i==letters.length-1){
                     focusNodes[i].unfocus();
                   }
                 }
               },
               style:  TextStyle(fontSize: w>900?20:w*0.03 ),
               textInputAction: TextInputAction.next,
               textAlign: TextAlign.center,
               decoration: const InputDecoration(
                   border: InputBorder.none,
                   counterText: ''
               ),
             ),
           ),
         ),
       )
       );
     }
     return l1;
   }

 void gameOver(){
   if(wrongCounter>1){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> GameOver( score: score,)));
   }
 }
  
  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    
    
    return  Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 100, 0),
                child: Text(
                  'Score $score',
                  style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
                ),
              ),
            ),

          ],
      ),
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/bg.png'),
          fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Container(
                    height: w>900?400:250,
                    width: w>900?w*0.33:w*0.5,
                    decoration:  BoxDecoration(
                      border: Border.all(
                        color: Colors.white24,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:
                    imgUrl==''
                  ?const Center(child: CircularProgressIndicator(),):
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(imgUrl),

                      ),
                    ),
                  ),
                  Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                        textFields(w),

                    ),
                  )),

                  AnimatedSwitcher(
                    duration: Duration(seconds: 4),
                  child: check?Padding(
                    key: Key('2'),
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: () {
                      setState(()  {
                        hint=false;
                        getUrl();
                        start=30;
                        result='';
                        check =false;
                      });
                    }, child: Text('NEXT',style: TextStyle(fontSize: 18),),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        fixedSize: MaterialStateProperty.all(Size(1.618*50, 50)),
                      ),
                    ),
                  ):
                  Padding(
                    key: Key('2'),
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){
                      if(hint){
                        dishName ='';
                        for(int i=0;i<ch.length;i++){
                          if(!checkVowel(ch[i])){
                            dishName=dishName+ch[i];
                          }
                        }
                      }
                      result = result.toLowerCase();
                      setState(() {
                        for(int i=0;i<fieldLength;i++) {
                          textEditingController[i].clear();
                        }
                        if(result==dishName){
                          BotToast.showAnimationWidget(

                            toastBuilder: (_)=>Container(child: Stack(

                              children: const [
                                CorrectAnimation(),
                              ],
                            )),
                            animationDuration: Duration(seconds: 0),
                            duration: Duration(seconds: 2),
                          );
                          check=true;
                          audioCache.load('sound.mp3');
                          audioCache.play('sound.mp3');
                          score++;
                          wrongCounter=0;
                        }else{
                          audioCache1.load('wrong.mp3');
                          audioCache1.play('wrong.mp3');
                          wrongCounter++;
                          result='';
                          gameOver();
                        }

                      });
                    }, child:Text('SURE',style: TextStyle(fontSize: 18),),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        fixedSize: MaterialStateProperty.all(Size(1.618*50, 50)),
                      ),
                    ),
                  ),

                  ),
                  !hint1?Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          fixedSize: MaterialStateProperty.all(const Size(1.618*40, 40)),
                        ),
                        onPressed: (){
                          setState(() {
                            hint1=true;
                            hint =true;
                          });

                    }, child: Text('Hint',style: TextStyle(fontSize: 15),)),
                  ):SizedBox(child: Center(child: Text('No Hint left',style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18),),),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

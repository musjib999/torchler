import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flashlight/flashlight.dart';

int brightness = 50;

enum Button{
  onButton,
  offButton
}
Button selectedButton = Button.offButton;

class TorchlerPage extends StatefulWidget {
  @override
  _TorchlerPageState createState() => _TorchlerPageState();
}

class _TorchlerPageState extends State<TorchlerPage> {
  bool _hasFlashlight = false;
  
  @override
  initState() {
    super.initState();
    initFlashlight();
  }

  initFlashlight() async{
    bool hasFlash = await Flashlight.hasFlashlight;
    setState(() {
      _hasFlashlight = hasFlash;
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedButton == Button.onButton ? kActiveBackgroundColor : kInactiveBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Center(
                child: Icon(
                  FontAwesomeIcons.lightbulb,
                  size: 200.0,
                  color: selectedButton == Button.onButton ? kIconOnColor : kIconOffColor,
                ),
              ),
            ),
            SizedBox(height: 130.0,),
            Center(
              child: Text(
                brightness.toString(),
                style: TextStyle(
                  color: selectedButton == Button.onButton ? Colors.white : Colors.black,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.brightness_low,
                    color: selectedButton == Button.onButton ? kIconOnColor : kIconOffColor
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: kActiveButton,
                    inactiveTrackColor: kInactiveButton,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 13.0),
                    thumbColor: kActiveButton,
                  ),
                  child: Expanded(
                    flex: 7,
                    child: Slider(
                      onChanged: (newValue){
                        setState(() {
                          brightness = newValue.round();
                        });
                      },
                      value: brightness.toDouble(),
                      min: 0,
                      max: 100,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.brightness_high,
                    color: selectedButton == Button.onButton ? kIconOnColor : kIconOffColor,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(40.0, 20.0, 0, 0),
                    padding: EdgeInsets.all(20.0),
                    width: 100.0,
                    height: 75.0,
                    decoration: BoxDecoration(
                      color: selectedButton == Button.offButton ? kActiveButton : kInactiveButton,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                      ),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedButton = Button.offButton;
                          });
                          Flashlight.lightOff();
                        },
                        child: Text(
                          'OFF',
                          style: kOffButtonTextStyle.apply(
                            color : selectedButton == Button.offButton ? kActiveTextColor : kInactiveTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 20.0, 40.0, 0),
                    padding: EdgeInsets.all(20.0),
                    width: 100.0,
                    height: 75.0,
                    decoration: BoxDecoration(
                      color: selectedButton == Button.onButton ? kActiveButton : kInactiveButton,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0)),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedButton = Button.onButton;
                          });
                          Flashlight.lightOn();
                        },
                        child: Text(
                          'ON',
                          style: kOnButtonTextStyle.apply(
                            color : selectedButton == Button.onButton ? kActiveTextColor : kInactiveTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

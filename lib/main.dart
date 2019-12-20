import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Animation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  var imgWidth = 80.0;

  AnimationController controller;

  Animation<double> growAnimation;

  Animation<Offset> slideAnimation1;
  Animation<Offset> slideAnimation2;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    controller =
        AnimationController(duration: Duration(milliseconds: 1100), vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.dispose();
            }
          });

    /* WidgetsBinding.instance.addPostFrameCallback((_) {
      growAnimation =
          Tween(begin: 0.0, end: MediaQuery.of(context).size.width * .80)
              .animate(CurvedAnimation(
        curve: Curves.easeInCirc,
        parent: controller,
      ));
    }); */

    growAnimation = Tween(begin: 0.0, end: 300.0).animate(CurvedAnimation(
      curve: Curves.easeInCirc,
      parent: controller,
    ));

    slideAnimation1 = Tween(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(curve: Curves.easeInCirc, parent: controller));

    slideAnimation2 = Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
        .animate(controller);

    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          '',
          style: TextStyle(color: Colors.blueGrey),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(tileMode: TileMode.mirror, colors: [
                  Color(0xff4286f4),
                  Color(0xff6c63ff),
                ]).createShader(bounds);
              },
              child: SlideTransition(
                position: slideAnimation2,
                child: Text(
                  "Flutter Animations",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            /*  AnimatedContainer(
              onEnd: () {
                print('$imgWidth');
              },
              width: imgWidth,
              duration: Duration(milliseconds: 800),
              // height: imgHeight,
              child: Image.asset(
                'assets/img/image.png',
                // width: imgWidth,
              ),
            ), */
            AnimatedBuilder(
              animation: controller,
              builder: (context, widget) {
                return Image.asset(
                  'assets/img/image.png',
                  fit: BoxFit.cover,
                  width: growAnimation.value,
                );
              },
            ),
            SizedBox(
              height: 60,
            ),
            SlideTransition(
              position: slideAnimation1,
              child: NiceButton(
                background: Color(0xff6c63ff),
                fontSize: 20,
                elevation: 3.0,
                radius: 50,
                gradientColors: [
                  Color(0xff6c63ff),
                  Color(0xff4286f4),
                ],
                onPressed: () {
                  setState(() {
                    // imgWidth = MediaQuery.of(context).size.width * .85;
                  });
                  // imgHeight = MediaQuery.of(context)
                },
                text: 'Welcome',
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

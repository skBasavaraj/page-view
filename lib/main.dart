import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  with SingleTickerProviderStateMixin {

  //declare the variables

  //declare the variables
  AnimationController? _animationController;
  Animation<double>? _nextPage;
  int _currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);
    int selectIndex =0;
  var size,height,width;


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
     });
  }
 @override
  void initState() {
     super.initState();
     _animationController =
     new AnimationController(vsync: this, duration: Duration(seconds: 10));
     _nextPage = Tween(begin: 0.0, end: 1.0).animate(_animationController!);

     //Add listener to AnimationController for know when end the count and change to the next page
     _animationController!.addListener(() {
       if (_animationController!.status == AnimationStatus.completed) {
         _animationController!.reset(); //Reset the controller
         final int page = 4; //Number of pages in your PageView
         if (_currentPage < page) {
           _currentPage++;
           _pageController.animateToPage(_currentPage,
               duration: Duration(milliseconds: 300), curve: Curves.easeInSine);
         } else {
           _currentPage = 0;
         }
       }
     });
  }
  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _animationController!.forward();

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 160,
              decoration: BoxDecoration(
                color:Colors.purple,
               ),
              child: PageView.builder(
                controller: _pageController,

                onPageChanged: (value) {
                  _animationController!.forward();

                  setState(() {
                    selectIndex = value;

                  });
                },
                 itemBuilder: ( context,index){
                return Padding(
                  padding:   EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(list[index].url!),
                      fit:BoxFit.cover,
                    )
                  ),
                    child: Stack(

                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Container(

                                width: width/2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                Padding(
                                  padding:   EdgeInsets.only(left: 10,top: 5),
                                  child: Text("Find Your Best Doctors ",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.white,letterSpacing: 1),softWrap: true,),
                                ),
                                Padding(
                                  padding:   EdgeInsets.only(left: 10),
                                  child: Text("Dr.doctors.name",style:  TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,),
                                )
                               /* ,Padding(
                                  padding:   EdgeInsets.only(left: 10),
                                  child: Text(" doctors.expertise} ",style:TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,),
                                )
                                ,Padding(
                                  padding:   EdgeInsets.only(left: 10),
                                  child: Text("doctors.location",style: TextStyle(fontSize: 12,color: Colors.white,fontWeight:  FontWeight.w400),overflow: TextOverflow.ellipsis,),
                                )
                              */  ,
                                   Container(
                                       width: 100,
                                       height: 30,
                                       child: Center(child: Text("Book Now",style: TextStyle
                                     ( color: Colors.white ),)),),



                               ],

                            ),
                          ),
                        )
                        ,Positioned(
                           right: 0,

                          child: Container(
                            height: 145,
                             child:Padding(
                               padding:   EdgeInsets.only(top: 5,right: 20),
                               child: Image.network("https://pngimg.com/uploads/doctor/doctor_PNG15988.png",                      fit:BoxFit.cover,
                            ),
                             ),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),

                          ),
                        )
                      ],
                    ),
                  ),
                );
              },itemCount:list.length,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                  ...List.generate(list.length, (index) =>     Indictor(isActive: selectIndex == index ? true : false
                  ))
                ],
            )
          ],
        ),
      ),
     );
  }
}
class Indictor extends StatelessWidget {
  final bool isActive;
  const  Indictor(  {  required this.isActive})  ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: AnimatedContainer(
        duration: Duration( milliseconds: 300),
        width: isActive ? 16:8,
        height: 10,
        decoration: BoxDecoration(
          color:isActive ? Colors.blueAccent : Colors.grey,
          borderRadius: BorderRadius.circular(10),

        ),
      ),
    );

  }
}

class Images {
  String? url;

  Images(this.url);

}
List<Images> list =[
  Images("https://www.jqueryscript.net/images/Create-An-Animated-Radial-Gradient-Background-With-jQuery-CSS3.jpg"),
  Images("https://designmodo.com/wp-content/uploads/2017/08/gradient-1.jpg"),
  Images("https://t4.ftcdn.net/jpg/02/21/39/93/360_F_221399332_MuA92wdjVCeRQv9AXY8p79hWGaTLMLWY.jpg"),
  Images("https://www.jqueryscript.net/images/Create-An-Animated-Radial-Gradient-Background-With-jQuery-CSS3.jpg"),
  Images("https://designmodo.com/wp-content/uploads/2017/08/gradient-1.jpg"),
  Images("https://t4.ftcdn.net/jpg/02/21/39/93/360_F_221399332_MuA92wdjVCeRQv9AXY8p79hWGaTLMLWY.jpg"),

];

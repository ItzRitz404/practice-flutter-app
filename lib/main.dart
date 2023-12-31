import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'node.dart';

List<Node> decisionMap = [];

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  String csv = "basic_map.csv";
  String fileData = await rootBundle.loadString(csv);
  // print(fileData);

  List<String> rows = fileData.split("\n");
  for (int i = 0; i < rows.length; i++) {
    // selects item from row and places
    String row = rows[i];
    List<String> itemInRow = row.split(","); 
    int item1 = int.parse(itemInRow[0]);
    int item2 = int.parse(itemInRow[1]);
    String item3 = itemInRow[2];
    Node node = Node(
      item1,
      item2,
      item3
    );
    decisionMap.add(node);
    // print('$i - $row');

  }

  runApp (
   const MaterialApp(
     home: MyFlutterApp(),
    ),
  );
}

class MyFlutterApp extends StatefulWidget {
 const MyFlutterApp({Key? key}) : super(key: key);

 @override
 State<StatefulWidget> createState() {
   return MyFlutterState();
 }
}

class MyFlutterState extends State<MyFlutterApp>{

  late int iD;
  late int nextID;
  String description = "";

  @override
  void initState() {
    super.initState();
   //PLACE CODE HERE TO INITALISE SERVER OBJECTS

    WidgetsBinding.instance.addPostFrameCallback((_) {
     //PLACE CODE HERE YOU WANT TO EXECUTE IMMEDIATELY AFTER
     //THE UI IS BUILT

      setState(() {
        Node current = decisionMap.first;
        iD = current.iD;
        nextID = current.nextID;
        description = current.description;
      });
   
    });
  }

  void buttonHandler () {
    setState(() {
      for(Node nextNode in decisionMap){
        if (nextNode.iD == nextID) {
          iD = nextNode.iD;
          nextID = nextNode.nextID;
          description = nextNode.description;
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     //Flutter UI Widgets go here
      backgroundColor: const Color(0xff3e87c5),
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Align(
                alignment: const Alignment(0.0, 0.0),
                child: MaterialButton(
                  onPressed: () { buttonHandler(); },
                  color: const Color(0xff3a21d9),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  ),
                  textColor: const Color(0xfffffdfd),
                  height: 40,
                  minWidth: 140,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    "press button",
                    style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, -0.3),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const  TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 34,
                    color: Color(0xffffffff),
                  ),
                ),
              ),


            
            
            
            
            
            
            
            ],






          ),
        ),
      ),

    );
  }
}


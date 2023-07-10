import 'dart:convert';
// import 'dart:ffi';
import 'package:flutter/material.dart';
// import crypto-related TPL
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

import 'dart:isolate';

import 'dart:math';

// test FLAG-related debug items
// import 'dart:developer' as developer;

int subLogic() {
  var length = 100;
  var n = 1;
  for (var i = 0; i < length; i++) {
    n = n + i;
    n = n * 2;
  }
  return n;
}

// new isolate
void isolateEntry(SendPort sendPort) {
  // operation logic
  // ......
  var sub_n = subLogic();
  sendPort.send('Hello from the sub-Isolate! nLogic equals to: ${sub_n}');
  
}

void main() {
  // set FLAG_print_class_table
  // developer.F = true;
  // listen from the sub isolate
  ReceivePort receivePort = ReceivePort();

  // initialize the sub isolate
  Isolate.spawn(isolateEntry, receivePort.sendPort);

  // get the information that is from the sub Isolate
  receivePort.listen((message){
    print("Received message from Isolate: \n");
    print(message);
    print("Sub Isolate returns message over!");
  });

  runApp(pointsCounter());
}

class pointsCounter extends StatefulWidget {
  @override
  State<pointsCounter> createState() => _pointsCounterState();
}


class varPrint {
  void SelfPrint1(){
    print("The 1-st self-defined function is called!");
  }

  void SelfPrint2(){
    print("The 2-nd self-defined function is called!");
  }

  void cipher_computing(int point){
    var bytes = utf8.encode(point.toString());
    var digest = sha1.convert(bytes);
    
    print("Digest as bytes: ${digest.bytes}");
    print("The 3-rd self-defined function is called!");
  }

  void transfer_string_int(String test_string, int test_int){
    print("Test_String: ${test_string}");
    print("Test_Int: ${test_int}");
  }

  void transfer_list_string(List test_list, String test_string){
    print("Test_List: ${test_list}");
    print("Test_String: ${test_string}");
  }

  //-----
  // void transfer_array_string(test_array, String test_string){
  //   print("Test_Array: ${test_array}");
  //   print("Test_String: ${test_string}");
  // }

  void transfer_bytedata_string(ByteData test_bytedata, String test_string){

    Uint8List uint8List = test_bytedata.buffer.asUint8List();
    
    print("Test_ByteData: ${uint8List}");
    print("Test_String: ${test_string}");
  }

  void transfer_longstring_longint(String test_longstring, BigInt test_longint){
    var length_test_longstring = test_longstring.length;

    print("Length of the Test_LongString: ${length_test_longstring}");
    print("The first 20 characters of Test_LongString: ${test_longstring.substring(0, 20)}");
    print("Test_LongInt in Decimal: ${test_longint}");
  }

  void transfer_conststring1_constring_2_varstring(String test_const_string1, String test_const_string2, String test_var_string){
    print("Test_Const_String1: ${test_const_string1}");
    print("Test_Const_String2: ${test_const_string2}");
    print("Test_Var_String1: ${test_var_string}");
  }

  void transfer_constbigint1_constbigint2_varbigint(BigInt test_const_bigint1, BigInt test_const_bigint2, BigInt test_var_bigint){
    print("Test_Const_LongInt1: ${test_const_bigint1}");
    print("Test_Const_LongInt2: ${test_const_bigint2}");
    print("Test_Var_LongInt1: ${test_var_bigint}");
  }

  String generate_test_varstring(){
    var test_var_string = "Test_to_resolve_var_string";
    return test_var_string;
  }

  BigInt generate_test_varbigint(){
    var test_var_bigint = BigInt.from(10).pow(100) - BigInt.from(3);
    return test_var_bigint;
  }
}

class Pconst {
  final value;
  Pconst(this.value);
  static Pconst call(value) => new Pconst(value);

  String toString() => "Pconst($value)";
}

class _pointsCounterState extends State<pointsCounter> {
  int teamAPoints = 0;

  int teamBPoints = 0;

  var var_print = varPrint();

  void addOnePoint() {
    print('add one point');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Points Counter'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Team E',
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        '$teamAPoints',
                        style: TextStyle(
                          fontSize: 150,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(8),
                          primary: Colors.orange,
                          minimumSize: Size(150, 50),
                        ),
                        onPressed: () {
                          setState(() {
                            teamAPoints++;
                            var_print.SelfPrint1();

                            String test_longstring = "a";
                            var random = Random();
                            for (var i_test_longstring = 0; i_test_longstring < 1500; i_test_longstring ++){
                              var charCode = random.nextInt(26) + 65; // 65-90 是大写字母的 ASCII 编码范围
                              var randomChar = String.fromCharCode(charCode);
                              test_longstring += randomChar;
                            }

                            BigInt test_longint = BigInt.from(10).pow(100) - BigInt.two;
                            var_print.transfer_longstring_longint(test_longstring, test_longint);
                          });
                          print(teamAPoints);
                        },
                        child: Text(
                          'Add 1 Point ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          minimumSize: Size(150, 50),
                        ),
                        onPressed: () {
                          setState(() {
                            teamAPoints += 2;
                            var_print.SelfPrint2();
                            var test = Pconst(10);
                            print("Hello, $test");
                            print("-----------");
                            var_print.transfer_string_int("Test_to_resolve_string", 2);
                          });
                        },
                        child: Text(
                          'Add 2 Point',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          minimumSize: Size(150, 50),
                        ),
                        onPressed: () {
                          setState(() {
                            teamAPoints += 3;
                            
                            var_print.cipher_computing(teamAPoints);

                            var_print.transfer_list_string([1, 2, 3], "Test_to_resolve_string");
                            
                            ByteData test_bytedata = ByteData(8);
                            test_bytedata.setInt32(0, 123456);
                            var_print.transfer_bytedata_string(test_bytedata, "Test_to_resolve_string");
                            
                            // test parameter transfer of BigInt varibles, including two distinct const BigInt and one function-returned var BigInt
                            BigInt test_var_bigint = var_print.generate_test_varbigint();
                            var_print.transfer_constbigint1_constbigint2_varbigint(BigInt.from(10).pow(100) - BigInt.from(5), BigInt.from(10).pow(100) - BigInt.from(4), test_var_bigint);
                            
                            // test parameter transfer of String varibles, including two distinct const String and one function-returned var String
                            String test_var_string = var_print.generate_test_varstring();
                            var_print.transfer_conststring1_constring_2_varstring("Test_to_resolve_const_string1", "Test_to_resolve_const_string2", test_var_string);
                          });
                        },
                        child: Text(
                          'Add 3 Point ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 500,
                  child: VerticalDivider(
                    indent: 50,
                    endIndent: 50,
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                Container(
                  height: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Team B',
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        '$teamBPoints',
                        style: TextStyle(
                          fontSize: 150,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(8),
                          primary: Colors.orange,
                          minimumSize: Size(150, 50),
                        ),
                        onPressed: () {
                          setState(() {});
                          teamBPoints++;
                        },
                        child: Text(
                          'Add 1 Point ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          minimumSize: Size(150, 50),
                        ),
                        onPressed: () {
                          setState(() {});
                          teamBPoints += 2;
                        },
                        child: Text(
                          'Add 2 Point ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(255, 152, 0, 1),
                          minimumSize: Size(150, 50),
                        ),
                        onPressed: () {
                          setState(() {
                            teamBPoints += 3;
                          });
                        },
                        child: Text(
                          'Add 3 Point ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(8),
                primary: Colors.orange,
                minimumSize: Size(150, 50),
              ),
              onPressed: () {
                setState(() {
                  teamAPoints = 0;
                  teamBPoints = 0;
                });
              },
              child: Text(
                'Reset',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

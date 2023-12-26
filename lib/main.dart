import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Palindrome Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final nameController = TextEditingController();
  final sentenceController = TextEditingController();

  bool isPalindrome(String string) {
    String cleanedString =
        string.replaceAll(RegExp(r'[\s+]', multiLine: true), '').toLowerCase();
    String reversedString = cleanedString.split('').reversed.join('');
    return cleanedString == reversedString;
  }

  void showPalindromeResult(bool result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Palindrome Check'),
          content: Text(result ? 'isPalindrome' : 'not palindrome'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "images/background.png"), // Update the path to images/bg.png
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage(
                      "images/ic_photo.png"), // Update the path to the profile photo
                ),
                SizedBox(height: 16.0),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 35.0,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12.0, horizontal: 5.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 35.0,
                  child: TextField(
                    controller: sentenceController,
                    decoration: InputDecoration(
                      hintText: 'Palindrome',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12.0, horizontal: 5.0),
                    ),
                  ),
                ),
                SizedBox(height: 64.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 35.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF2B637B), // Background color: #2B637B
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'CHECK',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                    onPressed: () => showPalindromeResult(
                        isPalindrome(sentenceController.text)),
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 35.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF2B637B), // Background color: #2B637B
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'NEXT',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            SecondScreen(userName: nameController.text),
                      ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  final String userName;

  SecondScreen({Key? key, required this.userName}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String selectedUserName = '';

  void updateUser(String userName) {
    setState(() {
      selectedUserName = userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,),
        body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Layer 1: Welcome name at the top
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome',
                style: TextStyle(fontSize: 12.0)
                ),
                Text(
                  widget.userName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ],
            ),
            
          ),
          
          // Layer 2: Selected user name in the center
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                 
                  Text(
                    'Selected User Name $selectedUserName',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                  ),
                ],
              ),
            ),
          ),
          
          // Layer 3: "Choose a User" button at the bottom
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 35.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF2B637B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Choose a User',
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  onPressed: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ThirdScreen(selectUser: updateUser),
                      ),
                    );

                    if (result != null) {
                      updateUser(result);
                  }
                },
              ),
            ),
          ),
          )
        ],
      ),
    );
  }
}

class ThirdScreen extends StatefulWidget {
  final Function(String) selectUser;

  ThirdScreen({Key? key, required this.selectUser}) : super(key: key);

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List<dynamic> users = [];
  int currentPage = 1;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  Future<void> _fetchUsers({bool refresh = false}) async {
    if (isLoading) return;
    if (refresh) currentPage = 1;

    setState(() => isLoading = true);

    final response = await http
        .get(Uri.parse('https://reqres.in/api/users?page=$currentPage'));
    final data = json.decode(response.body);

    if (refresh) {
      users.clear();
    }

    setState(() {
      users.addAll(data['data']);
      currentPage++;
      isLoading = false;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isLoading) {
      _fetchUsers();
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,),
      body: RefreshIndicator(
        onRefresh: () => _fetchUsers(refresh: true),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: users.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < users.length) {
              var user = users[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: const Color.fromARGB(255, 243, 241, 241)), // Add a top border
                    bottom: BorderSide(color: const Color.fromARGB(255, 235, 234, 234)), // Add a bottom border
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user['avatar']),
                  ),
                  title: Text('${user['first_name']} ${user['last_name']}'),
                  subtitle: Text(user['email']),
                  onTap: () {
                    widget.selectUser(
                        '${user['first_name']} ${user['last_name']}');
                    Navigator.pop(
                        context, '${user['first_name']} ${user['last_name']}');
                  },
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),
    );
  }
}

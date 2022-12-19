import 'package:flutter/material.dart';
import 'package:hive_database/hive_methods.dart';
import 'package:hive_database/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final HiveMethods hiveMethods = HiveMethods();
  List<UserModel> users = [];
  bool isLoading = true;



  @override
  void initState() {
    super.initState();
    fetchUsers();
  }


  void fetchUsers() async {
    var usersData = await hiveMethods.getUserLists();
    print("User Data = $usersData");
    if(usersData.isNotEmpty) {
      users.addAll(usersData);
    }
    setState(() {
      isLoading = false;
    });
  }

  void addUser() {
    hiveMethods.addUser(UserModel(
        id: 2,
        username: 'Kunal',
        email: 'kunal@gmail.com'
    ));
    print("User added");
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive DB'),
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: users.length,
          itemBuilder: (BuildContext context, index) {
            print("Username: ${users[index].username}");
            return Card(
              child: ExpansionTile(
                expandedAlignment: Alignment.centerLeft,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                backgroundColor: Colors.white,
                childrenPadding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                title: Text(users[index].username),
                children: [
                  Text('ID: ${users[0].id }'),
                  Text('Username: ${users[0].username}'),
                  Text('Email: ${users[0].email}')
                ],
              ),
            );
          },
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addUser();
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        )
    );
  }
}

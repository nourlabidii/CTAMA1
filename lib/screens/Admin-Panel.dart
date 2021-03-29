import 'package:CTAMA/backend/database.dart';
import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  List userProfilesList = [];

  @override
  initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseService().getUsersList();
    if (resultant == null) {
      print('unable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }

  Widget _buildsinglecontainer(
      {IconData icon, int count, String name, BuildContext context}) {
    return Card(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(name,
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(count.toString(),
                  style: TextStyle(
                      fontSize: 33,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold))
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.orange[900], Colors.orange[200]],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
          title: Text('Admin_Panel'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () {},
              label: Text(
                'Déconnexion',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            indicatorWeight: 3,
            unselectedLabelColor: Colors.blue[500],
            tabs: [
              Text(
                'Dashboard ',
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Management',
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        body: Container(
          child: TabBarView(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: GridView.count(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                children: [
                  _buildsinglecontainer(
                    context: context,
                    count: 1,
                    icon: Icons.person,
                    name: "Agents",
                  ),
                  _buildsinglecontainer(
                    context: context,
                    count: 1,
                    icon: Icons.person,
                    name: "Experts",
                  ),
                  _buildsinglecontainer(
                    context: context,
                    count: 1,
                    icon: Icons.location_city_sharp,
                    name: "Agences",
                  ),
                  _buildsinglecontainer(
                    context: context,
                    count: 1,
                    icon: Icons.agriculture_rounded,
                    name: "Agriculteurs",
                  ),
                  _buildsinglecontainer(
                    context: context,
                    count: 1,
                    icon: Icons.landscape,
                    name: "Parcelles",
                  ),
                  _buildsinglecontainer(
                    context: context,
                    count: 1,
                    icon: Icons.dangerous,
                    name: "Sinistres",
                  ),
                ],
              ),
            ),
            Container(
              child: ListView.builder(
                  itemCount: userProfilesList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(userProfilesList[index]['name']),
                        subtitle: Text(userProfilesList[index]['email']),
                      ),
                    );
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}

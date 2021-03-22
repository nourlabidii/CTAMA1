import 'package:flutter/material.dart';

class Admin extends StatelessWidget {
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
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      color: Colors.orange[800],
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: FlatButton.icon(
                        icon: Icon(
                          Icons.person,
                          color: Colors.blue[900],
                        ),
                        onPressed: () {},
                        label: Text(
                          'Manage Agents accounts',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    RaisedButton(
                      child: Icon(Icons.admin_panel_settings),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      color: Colors.orange[800],
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: FlatButton.icon(
                        icon: Icon(
                          Icons.person,
                          color: Colors.blue[900],
                        ),
                        onPressed: () {},
                        label: Text(
                          'Manage Experts account',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}

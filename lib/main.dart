import 'package:flutter/material.dart';

import 'package:flutter_navigator2_example/ScreenArguments.dart';

void main() {
  runApp(Nav2App());
}

class Nav2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (RouteSettings settings) {
        print(settings);
        print(settings.name);
        print(settings.arguments);

        // Handle '/'
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => HomeScreen());
        }

        // Handle '/details/:id'
        var uri = Uri.parse(settings.name);
        print(uri);
        print(uri.pathSegments.length);
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'details') {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(builder: (context) => DetailScreen(id: id));
        } else if (uri.pathSegments.length == 3 &&
            uri.pathSegments.first == 'details') {
          var id = uri.pathSegments[1];
          var id2 = uri.pathSegments[2];

          ScreenArguments args = settings.arguments;

          return MaterialPageRoute(
              builder: (context) => DetailScreen(
                    id: id,
                    id2: id2,
                    title: args.title,
                    message: args.message,
                  ));
        }

        return MaterialPageRoute(builder: (context) => UnknownScreen());
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigator 2.0'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('View Details 0/5'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/details/0/5',
                  arguments: ScreenArguments('title1', 'message1')
                );
              },
            ),
            ElevatedButton(
              child: Text('View Details 1/6'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/details/1/6',
                  arguments: ScreenArguments('title2', 'message2')
                );
              },
            ),
            ElevatedButton(
              child: Text('View Details 2/7'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/details/2/7',
                  arguments: ScreenArguments('title3', 'message3')
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String id;
  final String id2;
  final String title;
  final String message;

  DetailScreen({
    Key key,
    this.id,
    this.id2,
    this.title,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DetailScreen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Viewing details for item id1:$id id2:$id2'),
            Text('title:$title message:$message'),
            FlatButton(
              child: Text('Pop!'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}

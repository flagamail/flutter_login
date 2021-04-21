import 'package:flutter/material.dart';
import 'package:inerview_task/user.dart';

class Dashboard extends StatelessWidget {
  final ModelUser user;

  Dashboard(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome ${user.username}'),
              Text('Email ${user.email}'),
              Text('Mobile ${user.mobile}'),
            ],
          ),
        ));
  }
}

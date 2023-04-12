import 'package:flutter/material.dart';

class Screen_Transaction extends StatelessWidget {
  const Screen_Transaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text('12\ndec'),
                  radius: 30,
                ),
                title: Text('10000'),
                subtitle: Text('Travel'),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: 10),
    );
  }
}

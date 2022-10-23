import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  Task({required this.title, required this.description, required this.totalPoints, required this.pointsCollected});

  String description;
  String title;
  int totalPoints;
  int pointsCollected; // the points collected so far
  State<Task> createState() => TaskState();
}

class TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold),),
            Text(widget.description),
            Stack(
              alignment: Alignment.center,
              children: [ClipRRect(
                  child: LinearProgressIndicator(
                    value: widget.pointsCollected / widget.totalPoints, 
                    minHeight: 20,),
              borderRadius: BorderRadius.circular(8),),
              Center( child: Text('${widget.pointsCollected}/${widget.totalPoints}'),)]
            )],
        ),
      ),
    );
  }
}
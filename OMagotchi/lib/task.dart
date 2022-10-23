import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  const Task({super.key, required this.title, required this.description, required this.totalPoints, required this.pointsCollected});

  final String description;
  final String title;
  final int totalPoints;
  final int pointsCollected; // the points collected so far
  @override
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
            Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold),),
            Text(widget.description),
            Stack(
              alignment: Alignment.center,
              children: [ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: widget.pointsCollected / widget.totalPoints,
                    minHeight: 20,),),
              Center( child: Text('${widget.pointsCollected}/${widget.totalPoints}'),)]
            )],
        ),
      ),
    );
  }
}
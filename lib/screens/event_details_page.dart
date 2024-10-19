import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/event_model.dart';
import '../screens/event_page.dart'; // Import the EventPage
import '../bloc/event_cubit.dart'; // Import the EventCubit
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Bloc for accessing the EventCubit

class EventDetailsPage extends StatelessWidget {
  final Event event;

  EventDetailsPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to the EventPage to edit the event
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EventPage(event: event), // Pass the current event
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Confirm deletion
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Delete Event'),
                    content: Text('Are you sure you want to delete this event?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context), // Cancel
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Call delete function
                          context.read<EventCubit>().deleteEvent(event.id!);
                          Navigator.pop(context); // Close dialog
                          Navigator.pop(context); // Go back to event list
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displaying the image
            event.imagePath.isNotEmpty
                ? Image.file(File(event.imagePath))
                : Image.asset(
              'assets/images/default_event_image.png',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(event.description),
            SizedBox(height: 16),
            Text(
              'Date: ${DateFormat('yMMMd').format(event.date)}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

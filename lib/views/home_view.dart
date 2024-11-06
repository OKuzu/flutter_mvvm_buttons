// lib/views/home_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart'; // Import the package
import '../viewmodels/button_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final view_model = Provider.of<ButtonViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(view_model.title),
        actions: [
          TextButton(
            onPressed: () async {
              if (view_model.isEditing) {
                await view_model.saveConfiguration();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(view_model.snack_bar_text)),
                );
              }
              view_model.toggleEditMode();
            },
            child: Text(view_model.isEditing ? view_model.save_text : view_model.editing_text),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ReorderableGridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: view_model.number_of_buttons,
              itemBuilder: (context, index) {
                final button = view_model.sortedButtons[index];
                return GestureDetector(
                  key: ValueKey(button.id),
                  onTap: view_model.isEditing ? () => view_model.toggleSelection(index) : null,
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: button.isSelected ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(button.text, style: TextStyle(color: Colors.white)),
                    ),
                  ),
                );
              },
              onReorder: (oldIndex, newIndex) {
                view_model.reorderButtons(oldIndex, newIndex);
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/button_model.dart';
import '../services/json_service.dart';

class ButtonViewModel extends ChangeNotifier {
  List<ButtonModel> buttons = [];
  bool isEditing = false;
  String title = 'Button Customization';
  String snack_bar_text = "Configuration saved!";
  String editing_text = 'Editing';
  String save_text = 'Save';
  int number_of_buttons = 4;

  ButtonViewModel() {
    _loadButtons();
  }

  Future<void> _loadButtons() async {
    buttons = await JsonService.getSavedButtons();
    notifyListeners();
  }

  void toggleEditMode() {
    isEditing = !isEditing;
    notifyListeners();
  }

  void toggleSelection(int index) {
    buttons[index].isSelected = !buttons[index].isSelected;
    notifyListeners();
  }

  void reorderButtons(int oldIndex, int newIndex) {
    if (isEditing) {
      final ButtonModel movedButton = buttons.removeAt(oldIndex);
      buttons.insert(newIndex, movedButton);
      notifyListeners();
    }
  }

  Future<void> saveConfiguration() async {
    await JsonService.saveButtons(buttons);
  }

  List<ButtonModel> get sortedButtons {
    return buttons.take(4).toList();
  }
}

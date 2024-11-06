class ButtonModel {
  final String companyCode;
  final String agentId;
  final String userName;
  final String sortNumber;
  final String name;
  final String text;
  final int menuType;
  final int id;
  bool isSelected;

  ButtonModel({
    required this.companyCode,
    required this.agentId,
    required this.userName,
    required this.sortNumber,
    required this.name,
    required this.text,
    required this.menuType,
    required this.id,
    this.isSelected = false,
  });

  factory ButtonModel.fromJson(Map<String, dynamic> json) {
    return ButtonModel(
      companyCode: json['company_code'],
      agentId: json['agent_id'],
      userName: json['user_name'],
      sortNumber: json['sort_number'],
      name: json['name'],
      text: json['text'],
      menuType: json['menu_type'],
      id: json['id'],
      isSelected: json['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_code': companyCode,
      'agent_id': agentId,
      'user_name': userName,
      'sort_number': sortNumber,
      'name': name,
      'text': text,
      'menu_type': menuType,
      'id': id,
      'isSelected': isSelected,
    };
  }
}

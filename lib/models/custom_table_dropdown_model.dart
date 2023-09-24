class CustomTableDropDownModel<T>{
  final int? id;
  final String label;
  final T? otherData;

  CustomTableDropDownModel({
    this.id,
    required this.label,
    this.otherData
  });
}
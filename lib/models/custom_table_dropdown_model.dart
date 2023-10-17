/// this is the value and the option of the row field when the row field is a dropdown
/// with a generic data type T
class CustomTableDropDownModel<T>{
  final int? id;
  final String label; /// only this label is required
  final T? otherData; /// T type data

  /// constructor
  CustomTableDropDownModel({
    this.id,
    required this.label,
    this.otherData
  });
}
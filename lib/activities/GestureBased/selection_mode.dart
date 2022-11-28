/// Creating an enum called SelectionModes with four values: single, multiple,
/// copy, and mirror.
enum SelectionModes {
  /// The default value.
  base,

  /// Selection mode for when it's necessary to
  /// select more button at the same time.
  multiple,

  /// Selection mode for when it's necessary to do the COPY command.
  repeat,

  /// Selection mode for when it's necessary to do the MIRROR command.
  mirror,

  /// Selection mode for when it's necessary to do select the cells.
  select,
}

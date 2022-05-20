Blockly.Dart['go'] = function(block) {
  var value_direction = Blockly.Dart.valueToCode(block, 'DIRECTION', Blockly.Dart.ORDER_ATOMIC);
  // TODO: Assemble Dart into code variable.
  var code = '...;\n';
  return code;
};

Blockly.Dart['direction'] = function(block) {
  var number_repetition = block.getFieldValue('REPETITION');
  var dropdown_direction = block.getFieldValue('DIRECTION');
  // TODO: Assemble Dart into code variable.
  var code = '...';
  // TODO: Change ORDER_NONE to the correct strength.
  return [code, Blockly.Dart.ORDER_NONE];
};

Blockly.Dart['cell'] = function(block) {
  var dropdown_name = block.getFieldValue('NAME');
  // TODO: Assemble Dart into code variable.
  var code = '...';
  // TODO: Change ORDER_NONE to the correct strength.
  return [code, Blockly.Dart.ORDER_NONE];
};

Blockly.Dart['paint'] = function(block) {
  var value_colurs = Blockly.Dart.valueToCode(block, 'Colurs', Blockly.Dart.ORDER_ATOMIC);
  var number_repetition = block.getFieldValue('Repetition');
  var value_pattern = Blockly.Dart.valueToCode(block, 'Pattern', Blockly.Dart.ORDER_ATOMIC);
  // TODO: Assemble Dart into code variable.
  var code = '...;\n';
  return code;
};

Blockly.Dart['colors'] = function(block) {
  var value_color1 = Blockly.Dart.valueToCode(block, 'color1', Blockly.Dart.ORDER_ATOMIC);
  var value_color2 = Blockly.Dart.valueToCode(block, 'color2', Blockly.Dart.ORDER_ATOMIC);
  var value_color3 = Blockly.Dart.valueToCode(block, 'color3', Blockly.Dart.ORDER_ATOMIC);
  var value_color4 = Blockly.Dart.valueToCode(block, 'color4', Blockly.Dart.ORDER_ATOMIC);
  // TODO: Assemble Dart into code variable.
  var code = '...';
  // TODO: Change ORDER_NONE to the correct strength.
  return [code, Blockly.Dart.ORDER_NONE];
};

Blockly.Dart['pattern'] = function(block) {
  var dropdown_pattern = block.getFieldValue('Pattern');
  // TODO: Assemble Dart into code variable.
  var code = '...';
  // TODO: Change ORDER_NONE to the correct strength.
  return [code, Blockly.Dart.ORDER_NONE];
};
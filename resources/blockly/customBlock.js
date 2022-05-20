Blockly.Blocks['go'] = {
  init: function() {
    this.appendValueInput("DIRECTION")
        .setCheck(["direction", "cell"])
        .appendField("Vai a");
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(230);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Blocks['direction'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldDropdown([['1','1'],['2','2'],['3','3'],['4','4'],['5','5'],['6','6']]),"REPETITION");
    this.appendDummyInput()
        .appendField(new Blockly.FieldDropdown([["destra","right"], ["sinistra","left"], ["sopra","up"], ["sotto","down"], ["diagonale sopra sinistra","diagonal up left"], ["diagonale sopra destra","diagonal up right"], [" diagonale sotto sinistra","diagonal down left"], ["diagonale sotto destra","diagonal down right"]]), "DIRECTION");
    this.setInputsInline(true);
    this.setOutput(true, "direction");
    this.setColour(230);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Blocks['cell'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldDropdown([["a3","OPTIONNAME"], ["a4","OPTIONNAME"], ["b3","OPTIONNAME"], ["b4","OPTIONNAME"], ["c1","OPTIONNAME"], ["c2","OPTIONNAME"], ["c3","OPTIONNAME"], ["c4","OPTIONNAME"], ["c5","OPTIONNAME"], ["c6","OPTIONNAME"], ["d1","OPTIONNAME"], ["d2","OPTIONNAME"], ["d3","OPTIONNAME"], ["d4","OPTIONNAME"], ["d5","OPTIONNAME"], ["d6","OPTIONNAME"], ["d7","OPTIONNAME"], ["e3","OPTIONNAME"], ["e4","OPTIONNAME"], ["f3","OPTIONNAME"], ["f4","OPTIONNAME"]]), "NAME");
    this.setOutput(true, "cell");
    this.setColour(230);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Blocks['paint'] = {
  init: function() {
    this.appendValueInput("Colurs")
        .setCheck(["Colours", "Array"])
        .appendField("Colori");
    this.appendDummyInput()
        .appendField("Ripetizioni")
        .appendField(new Blockly.FieldDropdown([['1','1'],['2','2'],['3','3'],['4','4'],['5','5'],['6','6']]),"REPETITION");
    this.appendValueInput("Pattern")
        .setCheck("Pattern")
        .appendField("Forma");
    this.setInputsInline(false);
    this.setPreviousStatement(true, null);
    this.setNextStatement(true, null);
    this.setColour(230);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Blocks['colors'] = {
  init: function() {
    this.appendValueInput("color1")
        .setCheck("Colour")
        .appendField("1");
    this.appendValueInput("color2")
        .setCheck("Colour")
        .appendField("2");
    this.appendValueInput("color3")
        .setCheck("Colour")
        .appendField("3");
    this.appendValueInput("color4")
        .setCheck("Colour")
        .appendField("4");
    this.setInputsInline(false);
    this.setOutput(true, "Colours");
    this.setColour(230);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};

Blockly.Blocks['pattern'] = {
  init: function() {
    this.appendDummyInput()
        .appendField(new Blockly.FieldDropdown([["destra","right"], ["sinistra","left"], ["sopra","up"], ["sotto","down"], ["diagonale sopra sinistra","diagonal up left"], ["diagonale sopra destra","diagonal up right"], [" diagonale sotto sinistra","diagonal down left"], ["diagonale sotto destra","diagonal down right"]]), "Pattern");
    this.setOutput(true, "Pattern");
    this.setColour(230);
 this.setTooltip("");
 this.setHelpUrl("");
  }
};
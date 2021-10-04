# Eval SWL mod

Calls and evaluates an arbitrary in-game function.


## Installation instructions

Extract the zip file into `<SWL directory>\Data\Gui\Custom\Flash\` and restart the game.


## Usage

To call a function, type in chat:

    /setoption Eval_Function "function_name"
    /setoption Eval_Arguments "[\"json expression\", \"of arguments object\"]"
    /setoption Eval_Return "this.result.eval.expression"
    /setoption Eval_Exec true

- The function is optional. If it's not supplied, the mod will directly evaluate Eval_Return.
- The arguments must be an array of objects.
- In the Eval_Return expression to refer to the result of the function call, use `this.result`.

The following code will be executed:

    var fun = eval(function_name);
    var args = parseJson('["json expression", "of arguments object"]');
    this.result = fun.apply(this, args);

    printToChat(eval("this.result.eval.expression"))



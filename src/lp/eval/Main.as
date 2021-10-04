import com.GameInterface.DistributedValue;
import com.GameInterface.UtilsBase;
import lp.eval.utils.JSON;

class lp.eval.Main {
    
    private static var s_app:Main;

    private var m_execDV:DistributedValue;
    private var m_functionDV:DistributedValue;
    private var m_argumentsDV:DistributedValue;
    private var m_returnDV:DistributedValue;

    private var result;

    public static function main(swfRoot:MovieClip) {
        s_app = new Main(swfRoot);
        
        swfRoot.onLoad = function() { Main.s_app.OnLoad(); };
        swfRoot.onUnload = function() { Main.s_app.OnUnload(); };
    }
    
    public function OnLoad() {
        m_execDV = DistributedValue.Create("Eval_Exec");
        m_functionDV = DistributedValue.Create("Eval_Function");
        m_argumentsDV = DistributedValue.Create("Eval_Arguments");
        m_returnDV = DistributedValue.Create("Eval_Return");

        m_execDV.SignalChanged.Connect(Execute, this);
    }

    public function OnUnload() {
        m_execDV.SignalChanged.Disconnect(Execute, this);
    }

    private function Execute() {
        if (!m_execDV.GetValue()) {
            return;
        }

        m_execDV.SetValue(undefined);
        result = undefined;

        var functionValue = m_functionDV.GetValue();
        var argumentsValue = m_argumentsDV.GetValue();
        var returnValue = m_returnDV.GetValue();

        var evalResult;
        if (functionValue) {
            var fun = eval(functionValue);
            var args = argumentsValue ? JSON.parse(argumentsValue) : [];
            result = fun.apply(this, args);
            evalResult = returnValue ? eval(returnValue) : result;
        } else {
            evalResult = eval(returnValue);
        }

        UtilsBase.PrintChatText("Eval_Function: " + functionValue);
        UtilsBase.PrintChatText("Eval_Arguments: " + argumentsValue);
        UtilsBase.PrintChatText("Eval_Return: " + returnValue);
        if (evalResult) {
            UtilsBase.PrintChatText("======== Output ========");
            UtilsBase.PrintChatText(evalResult);
        } else {
            UtilsBase.PrintChatText("No output");
        }
    }
    
}
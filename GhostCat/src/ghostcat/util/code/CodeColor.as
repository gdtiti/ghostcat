package ghostcat.util.code
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import ghostcat.util.text.UBB;
	
	/**
	 * 
	 * @author Administrator
	 * 
	 */
	public class CodeColor extends EventDispatcher
	{
		static public var colors:Object = {
			"9900cc":"\\b(package|interface|class)\\b",
			"0033ff":"\\b(import|public|private|protected|extends|const|for|do|while|if|else|new|in|this|void|null)\\b",
			"339966":"\\b(function)\\b",
			"cc6666":"\\b(trace)\\b",
			"6699cc":"\\b(var)\\b",
			"990000":"(['\"]).*?(?<!\\\\)\\1",
			"3f5fbf":"/\\*.*?\\*/",
			"009900":"//.*\\r"
		}
		static public function parse(textField:TextField,colors:Object = null):void
		{
			if (!colors)
				colors = CodeColor.colors;
				
			var html:String = textField.text;
			textField.setTextFormat(new TextFormat(null,null,0));
			for (var p:String in colors)
			{
				html = html.replace(new RegExp(colors[p],"gm"),relpFunction);
			}
			
			function relpFunction():String
			{
				var len:int = arguments[0].length;
				var index:int = arguments[arguments.length - 2];
				textField.setTextFormat(new TextFormat(null,null,parseInt(p,16)),index,index + len);
				return arguments[0];
			}
		}
		
		static public function addChangeListener(textField:TextField,colors:Object = null):void
		{
			textField.addEventListener(Event.CHANGE,changeHandler);
			changeHandler(null);
			function changeHandler(e:Event):void
			{
				parse(textField,colors);
			}
		}
	}
}
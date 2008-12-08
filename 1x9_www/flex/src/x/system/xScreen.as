package x.system
{
    import flash.display.DisplayObject;
    
    import mx.containers.VBox;
    
    import org.amqp.patterns.CorrelatedMessageEvent;

    public class xScreen extends VBox
    {

        public var display:xRenderEntry;
        
        // properties
        public var entryLineRenderMode:String;

        private var entry:xEntry;
        private var lines:Array;
        private var _lines:Array; // cache
        
        private var setting:xSetting;
		private var console:xConsole;

        //private var current_line:int;

        public function xScreen()
        {
        }

        public function init():void
        {
            lines = new Array();
			
        	setting = xSetting.getInstance();
        	
        	// todo:        	
			// entryLineRenderMode = setting.find("entryLineRenderMode"); 
			entryLineRenderMode = "lines";
			
            //display = new xRenderEntry(null);
            //addChild(display);
        }

        public function addConsole(console:xConsole):void
        {
        	this.console = console;
            this.addChild(console.input);
        }

        public function show(str:String):void
        {
            var line:xEntryLine = new xEntryLine();
            line.obj.val = str;
            lines.push(line);
            //current_line++;
            trace("show: " + str);
        }

        public function clearDisplay():void
        {
            if (display != null)
            {
                display.removeAllChildren();
                removeChild(display);
                lines = new Array();
            }
        }

        public function renderEntry(entry:xEntry):void
        {
            clearDisplay();

            this.entry = entry;
            this.entry.obj.renderMode = "words";
            
            display = new xRenderEntry(entry);
            addChild(display);
            
        }

        public function renderLine(event:CorrelatedMessageEvent):void
        {
            var result:Object = event.result;

            var displayObj:DisplayObject;

            if (result != null)
            {

                trace("renderLine: ");
                
                if (result.result.entry_line)
                { 
	                var entry_line:xEntryLine = new xEntryLine();
	                entry_line.obj = result.result.entry_line;
	                displayObj = entry_line.render();
	                lines.push(entry_line);
	                display.addLine(displayObj);
	           }
                //current_line++;
            }
        }
        
        public function showError(str:String):void
        {
            show(str);
        }

        public function handleAction(msg:Object):void
        {
            var action:String = msg.action;
            trace ("handleAction: " + action);
            switch (action)
            {
                case "welcome":
            }
        }
    }
}
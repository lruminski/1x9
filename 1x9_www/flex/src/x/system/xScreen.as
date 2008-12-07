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
            
            entry.show(renderWords);
            
            display = new xRenderEntry(entry);
            addChild(display);
            
            
        }

        public function renderLine(event:CorrelatedMessageEvent):void
        {
            var result:Object = event.result;

            var displayObj:DisplayObject;

            if (result != null)
            {
<<<<<<< HEAD:1x9_www/flex/src/x/system/xScreen.as

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
        
        public function renderWords(event:CorrelatedMessageEvent):void
        {
        	
            var result:Object = event.result;

            var displayObj:DisplayObject;
            var entry_line:xEntryLine;
            
        	var i:int;

            if (result != null)
            {

                trace("renderLine: ");
                
                if (result.result)
                { 
                	
                	var words:Array = result.result;
                	for (i = 0; i < words.length; i++)
                	{
                		
                		var word:Object = words[i];
	                	if (!lines[word.line_num])
	                	{
			                entry_line = new xEntryLine(word.line_num, word.line_id, word.val, entry);
	                	} else {
	                		entry_line = lines[i];
	                		entry_line.update_word(word.val, word.pos);
	                	}
		                
		                displayObj = entry_line.render();
		                
		                display.addLine(displayObj);
                		
                	} 
                	
	           }
                //current_line++;
=======
            	/*
				if (result.result.words == null)
				{
	                trace("renderLine: ");
	                var line:xEntryLine = new xEntryLine();
	                line.obj = result.result.entry_line;
	                displayObj = line.render();
	                lines.push(line);
	                display.addLine(displayObj);
	                //current_line++;
	   			}
	   			else
	   			{
	   				trace("renderWords: ");
	   			}
	   			*/
>>>>>>> d48e805d3c2fc3ae44eff31bd83661076ecb0b8e:1x9_www/flex/src/x/system/xScreen.as
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
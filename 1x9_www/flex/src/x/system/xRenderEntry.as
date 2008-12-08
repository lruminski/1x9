package x.system
{
    import caurina.transitions.Tweener;
    
    import flash.display.DisplayObject;
    
    import mx.containers.VBox;
    import mx.events.ChildExistenceChangedEvent;
    
    import org.amqp.patterns.CorrelatedMessageEvent;
    
    import x.lib.Network;
    
    public class xRenderEntry extends VBox
    {
    	public const RENDER_TIME:Number = 0.333;
    	public const MAX_PAUSE_TIME:Number = 5;
    	
        private var entry:xEntry;
        private var comm:Network;

        private var lines:Array;

        public function xRenderEntry(entry:xEntry = null)
        {
            
            lines = new Array();

            if (entry != null)
            {
	            this.entry = entry;
	            render()
	       	}
            
            comm = Network.getInstance();            
            //comm.subscribe("entry", "test", consumeEntry);
            //comm.subscribe("entry", entry.obj.id, consumeEntry);
            //comm.serv.send("entry", "render", entry.obj.id, doNothing);
            this.addEventListener(ChildExistenceChangedEvent.CHILD_ADD, added);
        }
        
        public function render():void
        {
        	trace("xRenderEntry: render()");
            entry.show(renderWords);
        }

        public function addLine(line:DisplayObject):void
        {
            this.addChild(line);
        }

        public function renderWords(event:CorrelatedMessageEvent):void
        {
        	
            var result:Object = event.result;

            var displayObj:DisplayObject;
            var entry_line:xEntryLine;
            
        	var i:int;

            if (result != null)
            {

                trace("renderWords: ");
                
                if (result.result)
                { 
                	
                	var words:Array = result.result;
                	
                	var last_time:Number = words[0].time_elapsed;
                	
                	for (i = 0; i < words.length; i++)
                	{
                		
                		var word:Object = words[i];
	                	if (!lines[word.line_num])
	                	{
			                entry_line = new xEntryLine(word.line_num, word.line_id, word.val, entry);
			                lines[word.line_num] = entry_line;
			                trace("new word: " + word.val + " {" + word.time_elapsed +"}");
	                	} else {
	                		entry_line = lines[word.line_num];
	                		entry_line.update_word(word.val, word.pos);
			                trace("upd word: " + word.val + " :: " + word.pos + " {" + word.time_elapsed +"}");
	                	}
	                	
	                	
		                
		                if (last_time - word.time_elapsed > MAX_PAUSE_TIME) 
		                	word.time_elapsed = last_time + MAX_PAUSE_TIME;
		                	
		                displayObj = entry_line.render(word.time_elapsed / 5);
		                
		                this.addLine(displayObj);
                		
                	} 
                	
	           }
                //current_line++;
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
            }
        }
        
        private function added(event:ChildExistenceChangedEvent):void
        {
        	var target:DisplayObject = event.target as DisplayObject;
			var delayIndex:Number = 1;
			Tweener.addTween(event.target, {alpha:1, time:RENDER_TIME, delay:delayIndex, transition:"easeOutSine"});
        }
        
        private function consumeEntry(event:CorrelatedMessageEvent):void
        {
        	var result:Object = event.result;
        	if (result)
        	{
        		trace("consumeEntry: ");
        		
        	}
        }
        
        private function doNothing(event:CorrelatedMessageEvent):void
        {
            // even nothing is something
        }
    }
}
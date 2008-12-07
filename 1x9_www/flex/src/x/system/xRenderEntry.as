package x.system
{
    import flash.display.DisplayObject;
    
    import mx.containers.VBox;
    
    import org.amqp.patterns.CorrelatedMessageEvent;
    
    import x.lib.Network;

    public class xRenderEntry extends VBox
    {
        private var entry:xEntry;
        private var comm:Network;

        public function xRenderEntry(entry:xEntry = null)
        {
<<<<<<< HEAD:1x9_www/flex/src/x/system/xRenderEntry.as
            
            if (entry != null)
            {
	            this.entry = entry;
	            render()
	       	}
=======
            this.entry = entry;
            
            comm = Network.getInstance();            
            comm.subscribe("entry", "test", consumeEntry);
            //comm.subscribe("entry", entry.obj.id, consumeEntry);
            comm.serv.send("entry", "render", entry.obj.id, doNothing);
>>>>>>> d48e805d3c2fc3ae44eff31bd83661076ecb0b8e:1x9_www/flex/src/x/system/xRenderEntry.as
        }

        public function render():void
        {
			for (var word:* in entry.obj.entry_lines)
			{
				
			}
        }

        public function addLine(line:DisplayObject):void
        {
            this.addChild(line);
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
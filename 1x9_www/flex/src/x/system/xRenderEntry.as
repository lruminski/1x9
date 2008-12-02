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

        public function xRenderEntry(entry:xEntry)
        {
            this.entry = entry;
            
            comm = Network.getInstance();            
            comm.subscribe("entry", "test", consumeEntry);
            //comm.subscribe("entry", entry.obj.id, consumeEntry);
            comm.serv.send("entry", "render", entry.obj.id, doNothing);
        }

        public function render():void
        {

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
package x.system
{
    import flash.display.DisplayObject;
    
    import mx.containers.VBox;

    public class xRenderEntry extends VBox
    {
        private var entry:xEntry;

        public function xRenderEntry(entry:xEntry = null)
        {
            
            if (entry != null)
            {
	            this.entry = entry;
	            render()
	       	}
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
    }
}
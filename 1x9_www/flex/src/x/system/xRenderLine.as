package x.system
{
    import mx.containers.HBox;

    public class xRenderLine extends HBox
    {
    	
    	private var entry_line:xEntryLine;
    	private var render_entry:xRenderEntry;
    	private var words:Array;
    	
        public function xRenderLine(render_entry:xRenderEntry)
        {
        	this.render_entry = render_entry;
        }

        public function render(entry_line:xEntryLine):void
        {
            this.entry_line = entry_line;
            var words_str:String = entry_line.obj.val;
            
            var words:Array = words_str.split(" ");
            for (var word:String in words) {
            	
            }

            //this.text = entry_line.obj.val;
        }

        public function moveUp():void
        {

        }
    }
}
package x.system
{
    import flash.events.MouseEvent;
    import flash.filters.BitmapFilterQuality;
    import flash.filters.DropShadowFilter;
    
    import mx.containers.HBox;

    public class xRenderLine extends HBox
    {
    	private var entry_line:xEntryLine;
    	private var render_entry:xRenderEntry;
    	private var words:Array;
    	
        public function xRenderLine()
        {
        	this.addEventListener(MouseEvent.MOUSE_OVER, showProperties);
        }
    	/*
        public function xRenderLine(render_entry:xRenderEntry)
        {
        	this.render_entry = render_entry;
        }
		*/
        public function render(entry_line:xEntryLine):void
        {
        	
        	var i:int;
        	var word:xRenderWord;
        	
			var line_str:String = entry_line.obj.val; 
			
			var words:Array = line_str.split(" ");
			
			for (i = 0; i < this.numChildren; i++)
			{
				word = this.getChildAt(i) as xRenderWord;
				word.update(words[i])
			}
			
			for (i = this.numChildren; i < words.length; i++)
			{
				word = new xRenderWord(words[i]);
				addChild(word);				
			} 
			
			
			var dropShadow:DropShadowFilter = new DropShadowFilter();
			dropShadow.color = 0x000000;
			dropShadow.blurX = 7;
			dropShadow.blurY = 7;
			dropShadow.angle = 45;
			dropShadow.alpha = 0.5;
			dropShadow.quality = BitmapFilterQuality.HIGH;
			dropShadow.distance = 3;
			
            this.filters = [dropShadow];
			
			/*
            this.entry_line = entry_line;
            var words_str:String = entry_line.obj.val;
            
            var words:Array = words_str.split(" ");
            for (var word:String in words) {
            	
            }
			*/
            //this.text = entry_line.obj.val;
        }

        public function moveUp():void
        {

        }
        
        private function showProperties(event:MouseEvent):void
        {
        	
        }
    }
}
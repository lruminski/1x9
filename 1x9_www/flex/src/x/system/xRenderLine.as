package x.system
{
<<<<<<< HEAD:1x9_www/flex/src/x/system/xRenderLine.as
    import flash.events.MouseEvent;
    import flash.filters.BitmapFilterQuality;
    import flash.filters.DropShadowFilter;
    
=======
>>>>>>> d48e805d3c2fc3ae44eff31bd83661076ecb0b8e:1x9_www/flex/src/x/system/xRenderLine.as
    import mx.containers.HBox;

    public class xRenderLine extends HBox
    {
<<<<<<< HEAD:1x9_www/flex/src/x/system/xRenderLine.as

        public function xRenderLine()
        {
        	this.addEventListener(MouseEvent.MOUSE_OVER, showProperties);
=======
    	
    	private var entry_line:xEntryLine;
    	private var render_entry:xRenderEntry;
    	private var words:Array;
    	
        public function xRenderLine(render_entry:xRenderEntry)
        {
        	this.render_entry = render_entry;
>>>>>>> d48e805d3c2fc3ae44eff31bd83661076ecb0b8e:1x9_www/flex/src/x/system/xRenderLine.as
        }

        public function render(entry_line:xEntryLine):void
        {
<<<<<<< HEAD:1x9_www/flex/src/x/system/xRenderLine.as
        	
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
=======
            this.entry_line = entry_line;
            var words_str:String = entry_line.obj.val;
            
            var words:Array = words_str.split(" ");
            for (var word:String in words) {
            	
            }

            //this.text = entry_line.obj.val;
>>>>>>> d48e805d3c2fc3ae44eff31bd83661076ecb0b8e:1x9_www/flex/src/x/system/xRenderLine.as
        }

        public function moveUp():void
        {

        }
        
        private function showProperties(event:MouseEvent):void
        {
        	
        }
    }
}
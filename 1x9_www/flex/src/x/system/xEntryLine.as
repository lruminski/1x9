package x.system
{
    import flash.display.DisplayObject;


    public class xEntryLine extends xEntry
    {

        public var screenObj:xRenderLine;
        private var entry:xEntry;

        public function xEntryLine(num:int = 0, id:int = -1, entry:xEntry = null, type:String = "entry_lines")
        {
            if (entry == null)
            {
                entry = new xEntry();
            }
            this.entry = entry;
            super(entry.id, type);

            obj.line_num = num;

            //words = new Array("");
        }

        public function update_words(entry_str:String):void
        {
        	if (obj == null)
        	{
        		obj = new Object;
        	}
        	
            if (obj.val != entry_str)
            {
                obj.val = entry_str;
                trace("update_words: " + obj.id + " " + obj.val);
                update(saveResult);
            }
        }

		/*
        public function render():DisplayObject
        {
            if (screenObj == null)
            {
                screenObj = new xRenderLine(entry);
            }

            screenObj.render(this);

            return screenObj;
        }
        */

    }
}
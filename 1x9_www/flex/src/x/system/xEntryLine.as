package x.system
{
    import flash.display.DisplayObject;


    public class xEntryLine extends xEntry
    {

        public var screenObj:xRenderLine;

        public function xEntryLine(num:int = 0, id:int = -1, entry:xEntry = null, type:String = "entry_lines")
        {
            if (entry == null)
            {
                entry = new xEntry();
            }
            super(entry.id, type);

            obj.line_num = num;

            words = new Array("");
        }

        public function update_words(entry_str:String):void
        {
            if (obj.val != entry_str)
            {
                obj.val = entry_str;
                conn.serv.send(type, "update_words", obj, doNothing);
            }
        }

        public function render():DisplayObject
        {
            if (screenObj == null)
            {
                screenObj = new xRenderLine();
            }

            screenObj.render(this);

            return screenObj;
        }
    }
}
package x.system
{
    import mx.controls.Text;

    public class xRenderLine extends Text
    {
        public function xRenderLine()
        {
        }

        public function render(entry_line:xEntryLine):void
        {
            //var entry_line:xEntryLine = obj;

            this.text = entry_line.obj.val;
        }

        public function moveUp():void
        {

        }
    }
}
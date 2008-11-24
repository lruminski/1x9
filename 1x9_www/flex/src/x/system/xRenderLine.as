package x.system
{
    import mx.controls.Text;

    public class xRenderLine extends Text
    {
        public function xRenderLine()
        {
        }

        public function render(obj:xEntryLine):void
        {
            this.text = obj.val;
        }

        public function moveUp():void
        {

        }
    }
}
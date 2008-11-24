package x.system
{
    import mx.containers.VBox;

    public class xRenderEntry extends VBox
    {
        private var entry:xEntry;

        public function xRenderEntry(entry:xEntry)
        {
            this.entry = entry;
        }

        public function render():void
        {

        }

        public function addLine(line:xRenderLine):void
        {
            this.addChild(line);
        }
    }
}
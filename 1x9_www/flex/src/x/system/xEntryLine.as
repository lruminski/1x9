package x.system
{
    import org.amqp.patterns.CorrelatedMessageEvent;

    public class xEntryLine extends xEntry
    {

        public function xEntryLine(id:int = -1, entry:xEntry = null, type:String = "entry_lines")
        {

            if (entry == null)
            {
                entry = new xEntry();
            }
            super(entry.id, type);

            words = new Array("");
        }

        public function update_words(entry_str:String):void
        {
            if (obj.val != entry_str)
            {
                obj.val = entry_str;
                conn.serv.send(type, "update_words", entry_str, doNothing);
            }
        }


    }
}
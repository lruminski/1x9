package x.system
{
	import mx.controls.Text;
	
	public class xRenderWord extends Text
	{
		public function xRenderWord(val:String)
		{
			this.text = val;
		}
		
		public function update(val:String):void
		{
			this.text = val;
		}

	}
}
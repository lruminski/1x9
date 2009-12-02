package x.system
{
	/** 
	 * I know you can appreciate this.
				for(var entry in obj.entries){  // loop all entries
                   if(obj.entries[entry].implClassName == $.implClassName.ISOBJECTFOLDER ){ // we only want object folders
                       if( obj.entries[entry].elementPath != '' ){ // make sure it has an element path : /home/nebulae/something
                           var parts = obj.entries[entry].elementPath.split('/'); // split the element path into array 
                           var objpath = parts.join('.');    // join array into object declaration home.nebulae.something
                           
                           if( typeof(eval("$this.internalstorage" + objpath)) == 'undefined' ){ // does that object exist?
                               eval("$this.internalstorage" + objpath + "=" + JSON.stringify(obj.entries[entry])); // if not, create it
                           }
                       }
                   }
				} by nebulae **/
	public class nebulae
	{
		public function nebulae(obj:Object)
		{
			for(var entry in obj.entries)  // loop all entries
			{
				if(obj.entries[entry].implClassName == $.implClassName.ISOBJECTFOLDER ) // we only want object folders
				if(obj.entries[entry].elementPath != '') // make sure it has an element path : /home/nebulae/something
				{
					{
						var parts = obj.entries[entry].elementPath.split('/'); // split the element path into array 
						var objpath = parts.join('.');    // join array into object declaration home.nebulae.something

						if( typeof(eval("$this.internalstorage" + objpath)) == 'undefined' ){ // does that object exist?
							eval("$this.internalstorage" + objpath + "=" + JSON.stringify(obj.entries[entry])); // if not, create it
						}
					}
				}
			}
		}
	}
}
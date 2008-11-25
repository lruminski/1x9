class EntryController < Application
  
  def index
  end
  
  def find(params)
    str = ''
    params.each do |key, val|
      str += "#{key} = '#{val}' AND "
    end
    str.chop!.chop!.chop!.chop!
    
    entry = Entry.find(:first, :conditions => str)
    
    if entry.nil?
      entry = Entry.create record(params)
    end    
    
    return entry
  end
  
  def render(id)
    lines = EntryLine.find(:all, :conditions => ["entry_id", id], :group => "line_num", :order => "updated_at DESC");
  end
  
  def get
  end
  
  def set
  end
  
  def update
  end
  
  
end
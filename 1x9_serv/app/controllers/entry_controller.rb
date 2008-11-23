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
      entry = Entry.new
    end
    
    return entry
  end
  
  def show
  end
  
  def update
  end
  
  
end
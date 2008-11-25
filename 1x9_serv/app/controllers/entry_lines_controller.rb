class EntryLinesController < Application
  
  def save(params)
    
    entry_line = EntryLine.create record(params)
    entry_line.save
    
    return entry_line
  end
    
  def update_words(params)
    line_str = record[:val]
    line_id =  record[:id]
    words = line_str.split " "
    
    
    
    return line_str
  end
  
end
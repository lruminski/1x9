class EntryLinesController < Application
  
  def save(params)
    params.symbolize_keys!;
    
    if params[:id] == -1
      params.delete_if {|key, value| key == :id }
    end
    
    entry_line = EntryLine.create params
    entry_line.save
    
    return entry_line
  end
    
  def update_words(line_str)
    return line_str
  end
  
end
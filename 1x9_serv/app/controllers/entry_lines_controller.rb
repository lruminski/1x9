class EntryLinesController < Application
  
  def save(params)
    entry_line = EntryLine.create record(params)
    entry_line.save    
    return entry_line
  end
  
  def show(params)
    params = record(params)
    EntryLine.find(params[:id])
  end
        
  def update(params)
    params = record(params)
    
    if params[:id].nil?
      entry_line = save(params)
    else
      entry_line = EntryLine.find(params[:id])
    end
    entry_line.update_words(params[:val])
    entry_line.save
    return entry_line
  end
  
end
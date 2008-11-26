class EntryLinesController < Application
  
  def save(params)
    entry_line = EntryLine.create record(params)
    entry_line.save    
    return entry_line
  end
  
  def show(params)
    params = record(params)
    entry_line = EntryLine.find(params[:id])
    
    words = EntryWords.find(:all, :conditions => ['line_id = ?', entry_line[:id]], :order_by => 'created_at DESC')
        
    words.each do |word|
      
      if created_at.nil?
        created_at = word[:created_at]
      end
      
      Kernel::sleep [1, (word[:created_at]-created_at) / 4].min
      
      user_publish(@session.user_id, {
        :action => 'renderWord',
      })
      
    end
        
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
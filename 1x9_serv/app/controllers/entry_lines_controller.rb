class EntryLinesController < Application
  
  def save(params)
    entry_line = EntryLine.create record(params)
    entry_line.save    
    return entry_line
  end
  
  def show(params)
    params = record(params)
    entry_line = EntryLine.find(params[:id])
    
    words = EntryWord.find(:all, :conditions => ['line_id = ?', entry_line[:id]], :order => 'created_at')

    created_at = nil    
    words.each do |word|
      
      if created_at.nil?
        created_at = word['created_at']        
      end
      
      word['time_elapsed'] = time_elapsed = word['created_at']-created_at;
      
      ### Grrrr.. can't publish
      #Kernel::sleep [1, (word['created_at']-created_at) / 4].min
      #      
      #puts 'publish[:renderWord] ' + @session.session_id.to_s
      #user_publish(@session.session_id, {
      #  :action => 'renderWord',
      #  :obj => word
      #})
    end
    result = {:entry_line => entry_line}#, :words => words}
    return result
  end
        
  def update(params)
    params = record(params)
    
    if params[:id].nil?
      entry_line = save(params)
      entry_line[:val] = ''
    else
      entry_line = EntryLine.find(params[:id])
    end
    entry_line.update_words(params[:val])

    if entry_line.frozen?
      puts "frozen"
      entry_line = EntryLine.find(:first, :conditions => ["entry_id = ? AND line_num = ?", params[:entry_id], params[:line_num]])
      entry_line.val = params[:val]
    end

    entry_line.save
    return entry_line
  end
  
end
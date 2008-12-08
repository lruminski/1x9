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
    #else 
    #  entry_words = EntryWord.find(:all, :conditions => ["entry"])
    end
    
    result = entry.dup
    result[:num_lines] = entry.num_lines;
    
    return result.attributes
  end
  
  def show(id)
    words = []
    last_created_at = first_created_at = nil
    last_time_elapsed = 0
    nil_time = 0.0
    lines = EntryLine.find(:all, :conditions => ["entry_id", id], :group => "line_num", :order => "updated_at");    
    
    lines.each do |line|
      if last_created_at.nil?
        first_created_at = line.words.first[:created_at]
        last_created_at = first_created_at
        
       
      end
      line.words.each do |word|      
        word[:time_elapsed] = word[:created_at]-first_created_at-nil_time.to_f
        time_since_last = word[:created_at]-last_created_at
        begin
          if time_since_last > 10
            nil_time = nil_time.to_f
            nil_time += time_since_last-10
            word[:time_elapsed] = last_time_elapsed.to_f + 10
          end
        end
        puts "#{word[:created_at]}, #{word[:time_elapsed]}, #{nil_time.to_f}, #{time_since_last}, #{last_time_elapsed}"
        last_created_at = word[:created_at]
        last_time_elapsed = word[:time_elapsed]
        words << word
      end
    end
    
    return words
  end

  #def render(id)
  #  #lines = EntryLine.find(:all, :conditions => ["entry_id", id], :group => "line_num", :order => "updated_at DESC");
  #  words = EntryWord.find(:all, :conditions => ['entry_id = ?', id], :order => 'created_at')
  #
  #  created_at = nil    
  #  words.each do |word|
  #    
  #    if created_at.nil?
  #      created_at = word['created_at']
  #    end
  #    
  #    ### Grrrr.. can't publish
  #    #Kernel::sleep [1, (word['created_at']-created_at) / 4].min
  #    #      
  #    #puts 'publish[:renderWord] ' + @session.session_id.to_s
  #    publish('entry', 'test', {
  #      :action => 'renderWord',
  #      :obj => word
  #    })
  #    
  #  end
  #  
  #end
  
  def get
  end
  
  def set
  end
  
  def update
  end
  
  
end
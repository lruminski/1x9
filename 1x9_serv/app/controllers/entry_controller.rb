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
    
    return entry
  end
  
<<<<<<< HEAD:1x9_serv/app/controllers/entry_controller.rb
  def show(id)
    lines = EntryLine.find(:all, :conditions => ["entry_id", id], :group => "line_num", :order => "updated_at DESC");
=======
  def render(id)
    #lines = EntryLine.find(:all, :conditions => ["entry_id", id], :group => "line_num", :order => "updated_at DESC");
    words = EntryWord.find(:all, :conditions => ['entry_id = ?', id], :order => 'created_at')

    created_at = nil    
    words.each do |word|
      
      if created_at.nil?
        created_at = word['created_at']
      end
      
      ### Grrrr.. can't publish
      #Kernel::sleep [1, (word['created_at']-created_at) / 4].min
      #      
      #puts 'publish[:renderWord] ' + @session.session_id.to_s
      publish('entry', 'test', {
        :action => 'renderWord',
        :obj => word
      })
      
    end
    
>>>>>>> d48e805d3c2fc3ae44eff31bd83661076ecb0b8e:1x9_serv/app/controllers/entry_controller.rb
  end
  
  def get
  end
  
  def set
  end
  
  def update
  end
  
  
end
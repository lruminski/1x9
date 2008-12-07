class Entry < ActiveRecord::Base
  has_many        :entry_line
  attr_readonly  :num_lines
  
  def num_lines
    line = EntryLine.find(:first, :select => "line_num", :order => "line_num DESC", :conditions => ["entry_id = ?", self.id] )    
    if (line.nil?)
      @num_lines = 0
    else
      @num_lines = line[:line_num] 
    end
  end
  
end

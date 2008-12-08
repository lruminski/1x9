class EntryLine < ActiveRecord::Base
  belongs_to    :entry
  has_many      :entry_word
  
  before_save   :is_entry

  def is_entry
    if self.entry_id.nil?
      entry = Entry.create
      self.entry_id = entry.id
    end
  end
  
  def words
    words = EntryWord.find(:all, :conditions => {:line_id => self.id}, :order => 'created_at')
    
    if !words.first.nil?
      created_at = words.first[:created_at]
    end
    
    words.each do |word|
      word.instance_variable_set(:@time_elapsed, word[:created_at]-created_at)
      created_at = word[:created_at]
    end
    
    @words = words
  end
  
  def update_words(str)
    if self.id.nil?
      self.is_entry
      self.save
    end
    
    # new words
    words_new = str.split " "
    
    # replace old words
    words_old = (val.split " ")
    
    #puts "update words: " + val + " -> " + str
     
    words_old.each_with_index do |word, idx|
      new_word = words_new[idx]
      if new_word != word
        #rails needs a create_or_update method 
        #EntryWord.create_or_update :val => new_word, :entry_id => self.entry_id, :line_id => self.id, :pos => idx, :line_num => self.line_num        
        puts "replace " + word + " with " + new_word
        sql = "INSERT INTO entry_words " +
          "(val, entry_id, line_id, pos, line_num, created_at) VALUES ('#{new_word}', '#{self.entry_id}', '#{self.id}', '#{idx}', '#{self.line_num}', now()) " +
          "ON DUPLICATE KEY UPDATE val='#{new_word}'"
        #puts (sql)
        ActiveRecord::Base.connection.execute(sql)        
      end
    end
    
    old_count = words_old.count || 0

    if (old_count - words_new.count) > 1
      puts "end."
      EntryWord.create :val => '', :entry_id => self.entry_id,  :line_id => self.id, :pos => words_new.count+1, :line_num => self.line_num
    end

    # words not yet added
    words_new = words_new[old_count..-1] || []
    puts "new words: " + words_new.to_s + ", " + old_count.to_s + ", " + str.split(" ").to_s + ", " + words_old.to_s
    words_new.each_with_index do |word, idx|
      puts "add: " + word
      #still getting duplicate (when )
      begin
        EntryWord.create :val => word, :entry_id => self.entry_id, :line_id => self.id, :pos => old_count+idx, :line_num => self.line_num
      rescue
        puts "destrying"
        self.destroy
      end

    end
    
    if !self.frozen?
      self.val = str
      self.save
    end
  end
  
end

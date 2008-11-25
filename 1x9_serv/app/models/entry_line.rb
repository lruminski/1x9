class EntryLine < ActiveRecord::Base
  belongs_to    :entry
  has_many      :entry_word
  
  before_save   :is_entry
  
  def is_entry
    if entry_id.nil?
      entry = Entry.create
      entry_id = entry.id
    end
  end
  
  def words
    entry_word = EntryWord.find(:all, :conditions => {:line_id => self.id}, :order => 'updated_at DESC')
  end
  
  def update_words(str)
    tmp = str.split " "
    words = val.split " "    
    words_old = words - tmp
    words_old.each_with_index do |word, idx|
      entry_word = tmp[idx]
      if tmp[idx] != word
        EntryWord.create :val => entry_word, :line_id => self.id, :pos => idx, :line_num => self.line_num
      end
    end
    
    words_new = tmp[words_old.count..-1]
    words_new.each_with_index do |word, idx|
      EntryWord.create :val => word, :line_id => self.id, :pos => idx+words_old.count, :line_num => self.line_num
    end
    if (words_old.count - words_new.count) > 1
      EntryWord.create :val => '', :line_id => self.id, :pos => words_new.count+1, :line_num => self.line_num
    end
  end
  
end

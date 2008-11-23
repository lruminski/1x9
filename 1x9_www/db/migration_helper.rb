module MigrationHelper
  def add_foreign_key(from_table, from_column, to_table, fk_options='')
    constraint_name = "fk_#{from_table}_#{from_column}"
    
    execute %{ALTER TABLE #{from_table} ADD CONSTRAINT #{constraint_name} FOREIGN KEY (#{from_column}) REFERENCES #{to_table}(id) #{fk_options}}
  
    add_index from_table, [from_column], :name => from_column
  end
  
  def drop_foreign_key(from_table, from_column, to_table)
    constraint_name = "fk_#{from_table}_#{from_column}"
    execute %{ALTER TABLE #{from_table} DROP FOREIGN KEY #{constraint_name}}
  end
  
  def init_location(id, name, address)
    Location.create :id => id, :name => name, :address => address
  end

  def init_controller(title, name)
    Controller.create :title => title, :name => name
  end

  def init_menu(menu, value, constant)
    Menu.create :menu => menu, :value => value, :constant => constant
  end
 
end
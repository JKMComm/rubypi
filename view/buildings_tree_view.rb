require_relative 'icon_column.rb'
require_relative 'text_column.rb'

class BuildingsTreeView < Gtk::TreeView
  def initialize(tree_or_list_model)
	@tree_or_list_model = tree_or_list_model
	
	super(@tree_or_list_model)
	
	# Create columns for the tree view.
	icon_column = IconColumn.new("Icon", 1)
	name_column = TextColumn.new("Name", 2)
	schematic_name_column = TextColumn.new("Schematic", 3)
	pg_used_column = TextColumn.new("PG Used", 4)
	cpu_used_column = TextColumn.new("CPU Used", 5)
	isk_cost_column = TextColumn.new("ISK Cost", 6)
	
	# Pack columns in tree view, left-to-right.
	self.append_column(icon_column)
	self.append_column(name_column)
	self.append_column(schematic_name_column)
	self.append_column(pg_used_column)
	self.append_column(cpu_used_column)
	self.append_column(isk_cost_column)
	
	# Signals
	# On double-click, remove the building.
	self.signal_connect("row-activated") do |tree_view, path, column|
	  row = self.selection
	  tree_iter = row.selected
	  
	  @tree_or_list_model.delete_building(tree_iter)
	end
	
	# Tree View settings.
	self.reorderable = true
	
	return self
  end
  
  def destroy
	self.children.each do |child|
	  child.destroy
	end
	
	super
  end
end
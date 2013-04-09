
require 'gtk3'

require_relative 'planet_view_widget.rb'
require_relative 'edit_factory_widget.rb'

class BuildingViewWidget < Gtk::Box
  def initialize(building_model)
	super(:vertical)
	
	# Hook up model data.
	@building_model = building_model
	
	# Create the top row.
	# Top row should contain a label stating what view we're looking at, followed by an UP button.
	top_row = Gtk::Box.new(:horizontal)
	
	building_view_label = Gtk::Label.new("Building View")
	
	# Add our up button.
	@up_button = Gtk::Button.new(:stock_id => Gtk::Stock::GO_UP)
	@up_button.signal_connect("pressed") do
	  return_to_planet_view
	end
	
	top_row.pack_start(building_view_label, :expand => true)
	top_row.pack_start(@up_button, :expand => false)
	self.pack_start(top_row, :expand => false)
	
	
	# Create the bottom row.
	# Bottom row should contain the specialized widget that lets you edit the building's model.
	bottom_row = Gtk::Box.new(:horizontal)
	
	if (@building_model.is_a? CommandCenter)
	  
	  # TODO
	  # Create an EditCommandCenterWidget.
	  @building_widget = Gtk::Label.new("TODO: EditCommandCenterWidget")
	  
	  
	elsif (@building_model.is_a? Extractor)
	  
	  # TODO
	  # Create an EditExtractorWidget.
	  @building_widget = Gtk::Label.new("TODO: EditExtractorWidget")
	  
	  
	elsif (@building_model.is_a? BasicIndustrialFacility or 
	       @building_model.is_a? AdvancedIndustrialFacility or
	       @building_model.is_a? HighTechIndustrialFacility)
	  
	  # Create an EditIndustrialFacilityWidget
	  @building_widget = EditFactoryWidget.new(@building_model)
	  
	  
	elsif (@building_model.is_a? Launchpad)
	  
	  # Create an EditIndustrialFacilityWidget
	  @building_widget = Gtk::Label.new("TODO: EditLaunchpadWidget")
	  
	  
	elsif (@building_model.is_a? StorageFacility)
	  
	  # Create an EditIndustrialFacilityWidget
	  @building_widget = Gtk::Label.new("TODO: EditStorageFacilityWidget")
	  
	  
	else
	  # Bitch and complain.
	  @building_widget = Gtk::Label.new("TODO: Error on unknown building model.")
	end
	
	
	bottom_row.pack_start(@building_widget, :expand => false)
	self.pack_start(bottom_row, :expand => true)
	
	return self
  end
  
  def destroy
	self.children.each do |child|
	  child.destroy
	end
	
	super
  end
  
  private
  
  def return_to_planet_view
	# Before we return, save the data to the model.
	# TODO - Get rid of the unless here.
	@building_widget.commit_to_model unless @building_widget.is_a?(Gtk::Label)
	
	$ruby_pi_main_gtk_window.change_main_widget(PlanetViewWidget.new(@building_model.planet))
  end
end
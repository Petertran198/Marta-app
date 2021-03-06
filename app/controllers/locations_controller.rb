class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  include LocationsHelper
  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    #Httparty.get is a method that will parse through the json and return us data, as a response, or in another word readable format for us to use .
    #@buses rn is holding all the infomation seen at this url 
    @buses = HTTParty.get('http://developer.itsmarta.com/BRDRestService/RestBusRealTimeService/GetAllBus')

    @bus_count = 0 
    @nearby_bus = []
    if valid_location(@location)
      @buses.each do |bus|
        if nearby(@location.longitude,@location.latitude,bus["LONGITUDE"].to_f, bus["LATITUDE"].to_f)
          @bus_count += 1 
          @nearby_bus.push(bus)
        end
      end
    else
      redirect_to new_location_path, notice: "Please enter a correct location"
    end


  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.require(:location).permit(:address, :city, :latitude, :longitude)
    end
end

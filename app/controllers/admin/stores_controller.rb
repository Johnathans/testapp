class Admin::StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /stores
  # GET /stores.json
  def index
    
    @stores = Store.where(:client_id => params[:client_id])
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
  end

  # GET /stores/new
  def new
    @store = Store.new
  end

  # GET /stores/1/edit
  def edit
  end


  # POST /stores
  # POST /stores.json
  def create
    @client = Client.find(params[:client_id])
    @store = @client.stores.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to [:admin, @client, @store], notice: 'Store was successfully created.' }
        format.json { render action: 'show', status: :created, location: @store }
      else
        format.html { render action: 'new' }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to [:admin, @client, @store], notice: 'Store was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:client_id, :branded_name, :status_code, :advertising_start_date, :advertising_end_date, :street, :city, :state, :zip, :url, :contact_name, :contact_email, :facility_number, :marketing_number, :logo_url)
    end
end

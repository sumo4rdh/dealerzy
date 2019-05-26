class DealersController < ApplicationController
  before_action :ustaw_dealera, only: [:show, :edit, :update, :destroy]

  # GET /dealers
  def index
    @sortuj = params[:sortuj]
    @filtruj = params[:filtruj]
    if @filtruj != nil
      filtrowani_dealerzy = Dealer.where(miasto: @filtruj)
    else
      filtrowani_dealerzy = Dealer.all
    end
    if @sortuj != nil
      @dealers = filtrowani_dealerzy.order(@sortuj)
    else
      @dealers = filtrowani_dealerzy
    end
    @samochody = sumaSamochodow(@dealers)
    @przychody = sumaPrzychodow(@dealers)
  end

  def sumaSamochodow(dealerzy_do_wyswietlenia)
    suma = 0
    dealerzy_do_wyswietlenia.each do |dealer|
      suma = suma + dealer.samochody
    end
    return suma
  end

  def sumaPrzychodow(dealerzy_do_wyswietlenia)
    przychody = 0
    dealerzy_do_wyswietlenia.each do |dealer|
      przychody = przychody + dealer.przychody
    end
    return przychody
  end

  # GET /dealers/1
  def show
  end

  # GET /dealers/new
  def new
    @dealer = Dealer.new
  end

  # GET /dealers/1/edit
  def edit
  end

  # POST /dealers
  def create
    @dealer = Dealer.new(dealer_params)

    respond_to do |format|
      if @dealer.save
        format.html { redirect_to @dealer, notice: 'Dodano nowego dealera.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /dealers/1
  def update
    respond_to do |format|
      if @dealer.update(dealer_params)
        format.html { redirect_to @dealer, notice: 'Dealer został zaktualizowany.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /dealers/1
  def destroy
    @dealer.destroy
    respond_to do |format|
      format.html { redirect_to dealers_url, notice: 'Pomyślnie usunięto Dealera.' }
    end
  end

  private
    def ustaw_dealera
      @dealer = Dealer.find(params[:id])
    end
    def dealer_params
      params.require(:dealer).permit(:nazwa, :adress, :telefon, :miasto, :wlasciciel, :samochody, :przychody)
    end
end

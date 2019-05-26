class DealersController < ApplicationController
  before_action :ustaw_dealera, only: [:show, :edit, :update, :destroy]

  # GET /dealers
  def index
    # zmienna obsługująca sortowanie
    @sortuj = params[:sortuj]
    # zmienna obsługująca filtrowanie
    @filtr = params[:filtr]
    # sprawdzamy czy filtrowanie istnieje
    if @filtr != nil
      # wyszukujemy spośród wszystkich dealerów tych których właściciel jest taki jak filtr
      filtrowani_dealerzy = Dealer.where(['wlasciciel LIKE ?', "%#{@filtr}%"])
    else
      # w przeciwnym wypadku dajemy wszystkich dealerów
      filtrowani_dealerzy = Dealer.all
    end
    # jeśli obsługujemy sortowanie sortowanie
    if @sortuj != nil
      # pobieramy deealerów w kolejności rosnącej w zależości od tego po czym szukamy
      @dealers = filtrowani_dealerzy.order(@sortuj)
    else
      # w przeciwnym wypadku nie sortujemy
      @dealers = filtrowani_dealerzy
    end
    # wywołujemy fukcje sumujące dla ilości samochodów i przychodu
    @samochody = sumaSamochodow(@dealers)
    @przychody = sumaPrzychodow(@dealers)
  end

  # definicja funkcji sumującej samochody
  def sumaSamochodow(dealerzy_do_wyswietlenia)
    suma = 0
    # pętla sumująca wartość z obiektu dealera  sume dostępnych samochodów
    dealerzy_do_wyswietlenia.each do |dealer|
      suma = suma + dealer.samochody
    end
    # zwracamy sumę samochodów
    return suma
  end
  # definicja funkcji sumującej przychód
  def sumaPrzychodow(dealerzy_do_wyswietlenia)
    przychody = 0
    # pętla sumująca wartość z obiektu dealera  sumę przychodu
    dealerzy_do_wyswietlenia.each do |dealer|
      przychody = przychody + dealer.przychody
    end
    # zwracamy przychód
    return przychody
  end

  # przejście do widoku jednego dealera
  def show
  end

  # przejście do widoku tworzenia dealera
  def new
    @dealer = Dealer.new
  end

  # przejście do widoku edycji jednego dealera
  def edit
  end

  # funkcja tworzenia dealera
  def create
    # tworzenie dealera z parametrów przekazanych z formularza
    @dealer = Dealer.new(dealer_params)
    # wysłanie danych do bazy danych
    respond_to do |format|
      if @dealer.save
        format.html { redirect_to @dealer, notice: 'Dodano nowego dealera.' }
      else
        format.html { render :new }
      end
    end
  end

  # funkcja akktualizacji dealera
  def update
    # wysłanie danych do bazy danych
    respond_to do |format|
      # zwróc ten tekst jeśli udany
      if @dealer.update(dealer_params)
        format.html { redirect_to @dealer, notice: 'Dealer został zaktualizowany.' }
      else
        format.html { render :edit }
      end
    end
  end

  # funkcja usunięcia dealera
  def destroy
    @dealer.destroy
    respond_to do |format|
      format.html { redirect_to dealers_url, notice: 'Pomyślnie usunięto Dealera.' }
    end
  end

  private
    # funkcja zwrotu tego właściwego dealera np do edycji na podstawie parametru przekazanego w adresie url
     def ustaw_dealera
      @dealer = Dealer.find(params[:id])
    end
    # funkcja ustawienia parametrów do przekazywania
    def dealer_params
      params.require(:dealer).permit(:nazwa, :adress, :telefon, :miasto, :wlasciciel, :samochody, :przychody, :query)
    end
end

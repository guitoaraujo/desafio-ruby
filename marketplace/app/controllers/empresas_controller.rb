class EmpresasController < ApplicationController
  before_action :authenticate_user!
  before_action :checkAdmin, except: [:setAdmin]
  
  include HTTParty
  #base_uri 'https://www.fossil.com.br/api/catalog_system/pub/products/search/'
  
  #get das empresas separados :D
  #fossil aprensentou valores nil em alguns preços. Replicada prevenção.
  #timex aprensentou erro nas buscas, erros aparentemente aleatórios :/
  #@response != response ??? -> @var = instance variable / var = local variable(only in this scope) :P
  #nao deu tempo de otimizar esses gets :(


  def index
    @fossil        = Loja.where(nome: "Fossil")
    if @fossil.count>0
      @proFossil   = Produto.where(loja_id: @fossil[0].id)
    end
      
    @timex         = Loja.where(nome: "Timex")
    if @timex.count>0 
      @proTimex    = Produto.where(loja_id: @timex[0].id)
    end

    @schumann      = Loja.where(nome: "Schumann")
    if @schumann.count>0
      @proSchumann = Produto.where(loja_id: @schumann[0].id)
    end

    @admin         = User.where(admin: true)
  end  

  # STEP 1
  def setAdmin
    User.create(email: 'admin@admin.com.br', password: '123456', admin: true)
    redirect_to action: "index"
  end

  # STEP 2
  ###################################################################
  ###FOSSIL FOSSIL FOSSIL
  ###################################################################
  def getFossil 
    require 'json'
    Loja.create(nome:"Fossil", website:"fossil.com.br", logo:"fossil-logo.png", email:"fossil@fossil.com.br", user_id: current_user.id)
    loja = Loja.where(nome: "Fossil")
    puts loja.count
    if loja.count<=0
      redirect_to action: "index" 
    end  
    j    = 0
    ary2 = Array.new #array que armazena as buscas(0-49 e 50-99)
    ary = [
      "https://www.fossil.com.br/api/catalog_system/pub/products/search?_from=0&_to=49",
      "https://www.fossil.com.br/api/catalog_system/pub/products/search?_from=50&_to=99"
    ]


    while j<2 #loop parse JSON e construção do response
      response = HTTParty.get(ary[j])
      j        = j+1
      @teste   = JSON.parse response.body
      ary2.push(@teste)
    end
    @i        = 0
    @response = ary2
    @count    = @response.count

    while @i<@count
      @z = 0
      while @z<50
        @parcelas     = @response[@i][@z]["items"][0]["sellers"][0]["commertialOffer"]["Installments"]
        arrayParcelas = []
        @parcelas.each do |p|
          @numParcela                = p["NumberOfInstallments"]
          arrayParcelas[@numParcela] = @numParcela
        end
        @totalParcelas = arrayParcelas.count - 1
        @produtoNome   = @response[@i][@z]["productName"]
        
        #previne que preço venha nil
        if @response[@i][@z]["items"][0]["sellers"][0]["commertialOffer"]["Installments"].empty? == true
          @preco = 0.00 #salva como 0.00 caso preço seja nil 
        else  
          @preco = @response[@i][@z]["items"][0]["sellers"][0]["commertialOffer"]["Installments"][0]["Value"]#caminho do preço FOSSIL
        end 
        @imagem        = @response[@i][@z]["items"][0]["images"][0]["imageUrl"]
        @url           = @response[@i][@z]["link"]

        #grava produtos FOSSIL no banco
        Produto.create!(
          nome: @produtoNome,
          preco: @preco,
          imagem: @imagem,
          url: @url,
          parcelas: @totalParcelas,
          user_id: current_user.id, #ID USER DEFAULT
          loja_id: loja[0].id #ID FOSSIL
        )
        
        @z = @z+1
      end
      @i = @i+1
    end
    @i = 0

    #redirect_to controller: :produtos
    redirect_to action: "index"
  end



  ###################################################################
  ###TIMEX TIMEX TIMEX
  ###################################################################
  def getTimex 
    require 'json'
    Loja.create(nome:"Timex", website:"timex.com.br", logo:"timex-logo.png", email:"timex@fossil.com.br", user_id: current_user.id)
    loja = Loja.where(nome: "Timex")
    if loja.count<=0
      redirect_to action: "index" 
    end
    j    = 0
    ary2 = Array.new #array que armazena as buscas(0-49 e 50-99)
    ary = [
      "https://www.timex.com.br/api/catalog_system/pub/products/search?_from=0&_to=49",
      "https://www.timex.com.br/api/catalog_system/pub/products/search?_from=50&_to=99"
    ]


    while j<2 #loop parse JSON e construção do response
      response = HTTParty.get(ary[j])
      j        = j+1
      @teste   = JSON.parse response.body
      ary2.push(@teste)
    end
    @i        = 0
    @response = ary2
    @count    = @response.count

    while @i<@count
      @z = 0
      while @z<50
        @parcelas     = @response[@i][@z]["items"][0]["sellers"][0]["commertialOffer"]["Installments"]
        arrayParcelas = []
        @parcelas.each do |p|
          @numParcela                = p["NumberOfInstallments"]
          arrayParcelas[@numParcela] = @numParcela
        end
        @totalParcelas = arrayParcelas.count - 1
        @produtoNome   = @response[@i][@z]["productName"]
        
        #previne que preço venha nil
        if @response[@i][@z]["items"][0]["sellers"][0]["commertialOffer"]["Installments"].empty? == true
          @preco = 0.00 #salva como 0.00 caso preço seja nil 
        else  
          @preco = @response[@i][@z]["items"][0]["sellers"][0]["commertialOffer"]["Installments"][0]["Value"]#caminho do preço TIMEX
        end 
        @imagem        = @response[@i][@z]["items"][0]["images"][0]["imageUrl"]
        @url           = @response[@i][@z]["link"]

        #grava produtos TIMEX no banco
        Produto.create!(
          nome: @produtoNome,
          preco: @preco,
          imagem: @imagem,
          url: @url,
          parcelas: @totalParcelas,
          user_id: current_user.id,#ID USER DEFAULT
          loja_id: loja[0].id #ID TIMEX
        )
        
        @z = @z+1
      end
      @i = @i+1
    end
    @i = 0

    #redirect_to controller: :produtos
    redirect_to action: "index"
  end

  ###################################################################
  ###SCHUMANN SCHUMANN SCHUMANN
  ###################################################################
  def getSchumann 
    require 'json'
    Loja.create(nome:"Schumann", website:"schumann.com.br", logo:"schumann-logo.png", email:"schumann@fossil.com.br", user_id: current_user.id)
    loja = Loja.where(nome: "Schumann")
    if loja.count<=0
      redirect_to action: "index" 
    end
    j    = 0
    ary2 = Array.new #array que armazena as buscas(0-49 e 50-99)
    ary = [
      "https://www.schumann.com.br/api/catalog_system/pub/products/search?_from=0&_to=49",
      "https://www.schumann.com.br/api/catalog_system/pub/products/search?_from=50&_to=99"
    ]


    while j<2 #loop parse JSON e construção do response
      response = HTTParty.get(ary[j])
      j        = j+1
      @teste   = JSON.parse response.body
      ary2.push(@teste)
    end
    @i        = 0
    @response = ary2
    @count    = @response.count

    while @i<@count
      @z = 0
      while @z<50
        @parcelas     = @response[@i][@z]["items"][0]["sellers"][0]["commertialOffer"]["Installments"]
        arrayParcelas = []
        @parcelas.each do |p|
          @numParcela                = p["NumberOfInstallments"]
          arrayParcelas[@numParcela] = @numParcela
        end
        @totalParcelas = arrayParcelas.count - 1
        @produtoNome   = @response[@i][@z]["productName"]
        
        #previne que preço venha nil
        if @response[@i][@z]["items"][0]["sellers"][0]["commertialOffer"]["Installments"].empty? == true
          @preco = 0.00 #salva como 0.00 caso preço seja nil 
        else  
          @preco = @response[@i][@z]["items"][0]["sellers"][0]["commertialOffer"]["Installments"][0]["Value"]#caminho do preço SCHUMANN
        end 
        @imagem        = @response[@i][@z]["items"][0]["images"][0]["imageUrl"]
        @url           = @response[@i][@z]["link"]

        #grava produtos SCHUMANN no banco
        Produto.create!(
          nome: @produtoNome,
          preco: @preco,
          imagem: @imagem,
          url: @url,
          parcelas: @totalParcelas,
          user_id: current_user.id,#ID USER DEFAULT
          loja_id: loja[0].id #ID SCHUMANN
        )
        
        @z = @z+1
      end
      @i = @i+1
    end
    @i = 0

    #redirect_to controller: :produtos
    redirect_to action: "index"
  end

  private

  def checkAdmin
    if !current_user or current_user.admin != true
      redirect_to root_path
    end
  end
end

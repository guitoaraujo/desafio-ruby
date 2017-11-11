class EmpresasController < ApplicationController
  before_action :authenticate_user!
  
  include HTTParty
  base_uri 'https://www.fossil.com.br/api/catalog_system/pub/products/search/'
  
  #get das empresas separados :D
  #fossil aprensentou valores nil em alguns preços. Replicada prevenção.
  #timex aprensentou erro nas buscas, erros aparentemente aleatórios :/
  #@response != response ??? -> @var = instance variable / var = local variable(only in this scope) :P
  #nao deu tempo de otimizar esses gets :(


  def index
    @fossil   = Produto.where(loja_id: 1)
    @timex    = Produto.where(loja_id: 2)
    @schumann = Produto.where(loja_id: 3)
  end  


  ###################################################################
  ###FOSSIL FOSSIL FOSSIL
  ###################################################################
  def getFossil 
    require 'json'
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
          user_id: 1,#ID USER DEFAULT
          loja_id: 1 #ID FOSSIL
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
          user_id: 1,#ID USER DEFAULT
          loja_id: 2 #ID TIMEX
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
          user_id: 1,#ID USER DEFAULT
          loja_id: 3 #ID SCHUMANN
        )
        
        @z = @z+1
      end
      @i = @i+1
    end
    @i = 0

    #redirect_to controller: :produtos
    redirect_to action: "index"
  end
end

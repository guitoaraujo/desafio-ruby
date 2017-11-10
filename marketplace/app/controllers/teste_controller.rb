class TesteController < ApplicationController

  include HTTParty

  base_uri 'https://www.fossil.com.br/api/catalog_system/pub/products/search/'

  def initialize #busca os produtos de três lojas e popula o banco
    require 'json'
    j= 0
    ary2 = Array.new #array que armazena as buscas(0-49 e 50-99)
    #array com os links de busca FOSSIL
    ary = [
      "https://www.fossil.com.br/api/catalog_system/pub/products/search?_from=0&_to=49",
      "https://www.fossil.com.br/api/catalog_system/pub/products/search?_from=50&_to=99"
    ]


    while j<2 #loop parse JSON e construção do response
      response = HTTParty.get(ary[j])
      j = j+1
      @teste = JSON.parse response.body
      ary2.push(@teste)
    end
    @i = 0
    @response = ary2
    @count = @response.count

    while @i<@count
      @z = 0
      while @z<50
        @parcelas    = @response[@i][@z]["items"][0]["sellers"][0]["commertialOffer"]["Installments"]
        arrayParcelas = []
        @parcelas.each do |p|
          @numParcela = p["NumberOfInstallments"]
          arrayParcelas[@numParcela] = @numParcela
        end
        @totalParcelas = arrayParcelas.count - 1
        @produtoNome = @response[@i][@z]["productName"]
        @preco       = @response[@i][@z]["items"][0]["sellers"][0]["commertialOffer"]["Installments"][0]["Value"] #$v->items[0]->sellers[0]->commertialOffer->Installments[0]->Value;
        @imagem      = @response[@i][@z]["items"][0]["images"][0]["imageUrl"]#$v->items[0]->images[0]->imageUrl;
        @url         = @response[@i][@z]["link"]#$v->link;

=begin
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
=end
        @z = @z+1
      end
      @i = @i+1
    end
    @i = 0

  end
end

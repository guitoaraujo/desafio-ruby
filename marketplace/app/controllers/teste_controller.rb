class TesteController < ApplicationController

  include HTTParty

  base_uri 'https://www.fossil.com.br/api/catalog_system/pub/products/search/'

  def initialize
     j= 0
     ary2 = Array.new

     ary = ["https://www.fossil.com.br/api/catalog_system/pub/products/search?_from=0&_to=49", "https://www.fossil.com.br/api/catalog_system/pub/products/search?_from=50&_to=99"]
    require 'json'

    while j<2

      response = HTTParty.get(ary[j])
      #puts response.body, response.code, response.message, response.headers.inspec
      j = j+1

      @teste = JSON.parse response.body

      # => "ABC Widget 2.0"
      ary2.push(@teste)

    end

    @i = 0
    @z = 0
    @resultado = ""

    @response = ary2
    @CONTADOR = @response.count

    while @i<@CONTADOR
      @z = 0

      while(@z<50)

        @nome = @teste[@z]["productName"]
        @url  = @teste[@z]["linkText"]
        @preco = @teste[@z]["productName"]
        @parcela  = @teste[@z]["linkText"]
        @imagem = @teste[@z]["images"]
        @z = @z+1
      end
      @i = @i+1
    end

  end

end

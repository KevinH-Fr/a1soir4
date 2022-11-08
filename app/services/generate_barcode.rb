class GenerateBarcode < ApplicationService
    attr_reader :produit
  
    def initialize(produit)
      @produit = produit
    end
  
    require 'barby'
    require 'barby/barcode/code_128'
    require 'barby/outputter/ascii_outputter'
    require 'barby/outputter/png_outputter'
  
    def call
      barcode = Barby::Code128B.new(produit.id)
  
      png = Barby::PngOutputter.new(barcode).to_png
  
      image_name = SecureRandom.hex
  
      IO.binwrite("tmp/#{image_name}.png", png.to_s)
  
      blob = ActiveStorage::Blob.create_and_upload!(
        io: File.open("tmp/#{image_name}.png"),
        filename: image_name,
        content_type: 'png'
      )
  
      produit.barcode.attach(blob)
    end
  end
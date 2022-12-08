class GenerateQr < ApplicationService
    attr_reader :produit

    def initialize(produit)
        @produit = produit
    end

    include Rails.application.routes.url_helpers

    require "rqrcode"
    
    def call
        qr_url = url_for(controller:'produits',
            action: "show",
            id: produit.id,
            only_path: false,
            host: 'a1soir.herokuapp.com',
            source: 'from_qr')

    qrcode = RQRCode::QRCode.new(qr_url)

    png = qrcode.as_png(
        bit_depth: 1,
        border_modules: 4,
        color_mode: ChunkyPNG::COLOR_GRAYSCALE,
        color: "black",
        file: nil,
        fill: "white",
        module_px_size: 6,
        resize_exactly_to: false,
        resize_gte_to: false,
        size: 120
      )

      image_name = SecureRandom.hex
      IO.binwrite("tmp/#{image_name}.png", png.to_s)
      
      blob = ActiveStorage::Blob.create_and_upload!(
        io: File.open("tmp/#{image_name}.png"),
        filename: image_name,
        content_type: "png"
      )

      produit.qr_code.attach(blob)
    end

end

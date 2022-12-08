class MonController < ApplicationController

    def generate_pdf
        @data = # insérez ici les données à afficher dans le PDF
      
        respond_to do |format|
          format.html
          format.pdf do
            render pdf: 'mon_pdf',
                   template: 'pdf/mon_pdf.html.erb',
                   layout: 'pdf.html.erb'
          end
        end
      end
      
end
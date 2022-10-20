
# fonctionne en prod : 

WickedPdf.config ||= {}
WickedPdf.config.merge!({
  layout: "pdf.html.erb",
}) 


# focntionne en dev :

#WickedPdf.config = {
#  :exe_path => 'C:\wkhtmltopdf\bin\wkhtmltopdf.exe'
#}
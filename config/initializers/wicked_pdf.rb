
if Rails.env.production?
  
# fonctionne en prod : 
  WickedPdf.config ||= {}
  WickedPdf.config.merge!({
    layout: "pdf.html.erb",
  }) 
else

  # focntionne en dev :
  WickedPdf.config = {
      :exe_path => 'C:\wkhtmltopdf\bin\wkhtmltopdf.exe',
      enable_local_file_access: true,
      layout: "pdf.html.erb",
      
  }

end 

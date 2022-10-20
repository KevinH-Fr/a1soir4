# config/initializers/grover.rb
Grover.configure do |config|
    config.options = {
      format: 'A4',
      margin: {
        top: '2px',
        bottom: '2px'
      },
      user_agent: 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0',
   #   viewport: {
   #     width: 640,
   #     height: 1080
   #   },

      full_page: true,

      prefer_css_page_size: true,
      emulate_media: 'screen',
      bypass_csp: true,
      media_features: [{ name: 'prefers-color-scheme', value: 'dark' }],
      timezone: 'Australia/Sydney',
    #  vision_deficiency: 'deuteranopia',
      extra_http_headers: { 'Accept-Language': 'en-US' },
      geolocation: { latitude: 59.95, longitude: 30.31667 },
    #  focus: '#some-element',
    #  hover: '#another-element',
      cache: false,
     # timeout: 0, # Timeout in ms. A value of `0` means 'no timeout'
     # request_timeout: 3000, # Timeout when fetching the content (overloads the `timeout` option)
     # convert_timeout: 2000, # Timeout when converting the content (overloads the `timeout` option, only applies to PDF conversion)
     launch_args: ['--font-render-hinting=medium'],
     # wait_until: 'domcontentloaded'
    }
  end
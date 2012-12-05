PARTIES_PATH = "/Users/shamu/Music/Superstijl"
STYLE_DURATION = 900 # in seconds

if !File.directory?(PARTIES_PATH)
  Rails.logger.error "Error : The configured parties folder does not exist (#{PARTIES_PATH}) please set it correctly in config/initializers/superstijl.rb"
end
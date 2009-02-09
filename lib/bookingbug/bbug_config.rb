module BookingBug
  class Config
    def self.read_config(config_file)
      config = YAML.load(ERB.new(IO.read(config_file)).result)
      config
    end
    
  end
end


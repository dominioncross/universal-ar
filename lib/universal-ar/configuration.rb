module UniversalAr
  class Configuration

    cattr_accessor :default_setting

    def self.reset
      self.default_setting   = true
    end

  end
end
UniversalAr::Configuration.reset
module UniversalAr
  class Config

    cattr_accessor :default_setting

    def self.reset
      self.default_setting   = true
    end

  end
end
UniversalAr::Config.reset
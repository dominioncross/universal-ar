module UniversalAr
  class Config

    cattr_accessor :use_scope

    def self.reset
      self.use_scope   = true
    end

  end
end
UniversalAr::Config.reset
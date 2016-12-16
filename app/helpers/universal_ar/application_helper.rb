module UniversalAr
  module ApplicationHelper
    
    def icon(i)
      return "<i class='fa fa-fw fa-#{i}'></i>".html_safe
    end
    
    #######COMPONENTS
    def panel(attrs={}, &block)
      render layout: '/universal_ar/components/panel', locals: {attrs: attrs}{
        capture(&block)
      }
    end

    def table(attrs={}, &block)
      render layout: '/universal_ar/components/table', locals: {attrs: attrs}{
        capture(&block)
      }
    end

    def modal(attrs={}, &block)
      render layout: '/universal_ar/components/modal', locals: {attrs: attrs}{
        capture(&block)
      }
    end

    def tabs(attrs={}, &block)
      render layout: '/universal_ar/components/tabs', locals: {attrs: attrs}{
        capture(&block)
      }
    end
    
  end
end
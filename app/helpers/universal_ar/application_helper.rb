module UniversalAr
  module ApplicationHelper

    def submit(title='Save', icon='check')
      button_tag("#{icon(icon)} #{title}".html_safe, class: 'btn btn-primary')
    end

    def submit_confirm(title='Save', icon='check', confirm_message='Are you sure?')
      button_tag("#{icon(icon)} #{title}".html_safe, class: 'btn btn-primary', data: {confirm: confirm_message, 'disable-with' => 'Loading...'})
    end

    def icon(i)
      return "<i class='fa fa-fw fa-#{i}'></i>".html_safe
    end

    #######COMPONENTS
    def panel(attrs={}, &block)
      render layout: '/universal_ar/components/panel', locals: {attrs: attrs} do
        capture(&block)
      end
    end

    def table(attrs={}, &block)
      render layout: '/universal_ar/components/table', locals: {attrs: attrs} do
        capture(&block)
      end
    end

    def modal(attrs={}, &block)
      render layout: '/universal_ar/components/modal', locals: {attrs: attrs} do
        capture(&block)
      end
    end

    def tabs(attrs={}, &block)
      render layout: '/universal_ar/components/tabs', locals: {attrs: attrs} do
        capture(&block)
      end
    end

  end
end

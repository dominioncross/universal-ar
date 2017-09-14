require_dependency "universal_ar/application_controller"

module UniversalAr
  class TagsController < UniversalAr::ApplicationController
    
    skip_before_action :validate_scope
    
    def index
      @model = params[:model_class].classify.constantize.find params[:model_id]
      render json: @model.tags.to_json
    end

    def create
      @model = params[:model_class].classify.constantize.find params[:model_id]
      tags = params[:tags].split(',').map{|t| t.strip.parameterize if !t.strip.blank?}.compact
      UniversalAr::KeyValue.where(subject_type: params[:model_class].classify, subject_id: params[:model_id], key: :tag).delete_all
      tags.each do |tag|
        @model.tag!(tag)
      end
      respond_to do |format|
        format.json{render json: {tags: tags}}
        format.js{render layout: false}
      end
    end
    
  end
end
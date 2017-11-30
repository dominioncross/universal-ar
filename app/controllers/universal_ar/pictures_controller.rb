require_dependency "universal_ar/application_controller"

module UniversalAr
  class PicturesController <  UniversalAr::ApplicationController
    
    skip_before_action :validate_scope
    before_action :find_subject
    
    def index
      if !@subject.nil?
        if !params[:redactor].blank?
          render json: @subject.pictures.map{|a| {
            thumb: a.image.url(:small),
            url: a.image.url,
            title: a.title,
            id: a.id
          }}
        else
          render json: {pictures: @subject.pictures.map{|a| a.to_json}}
        end
      else
        render json: {pictures: []}  
      end
      
    end
    
    def create
      if !@subject.nil?
        if !params[:file].blank?
          att = @subject.pictures.create image: params[:file], scope: @subject.scope, user: current_user
          render json: { url: att.image.url, id: att.id.to_s }
        elsif !params[:files].blank?
          pictures = []
          params[:files].each do |file|
            att = @subject.pictures.create image: file, scope: @subject.scope, name: params[:name], user: current_user
            puts att.errors.to_json
            pictures.push(att)
          end
          render json: {pictures: @subject.pictures.map{|a| a.to_json}}
        end
      end
    end
   
    def destroy
      @picture = UniversalAr::Picture.find(params[:id])
      @subject = @picture.subject
      @picture.destroy
      render json: {pictures: @subject.pictures.map{|a| a.to_json}}
    end
   
    private
    def find_subject
      if !params[:subject_type].blank? and params[:subject_type] != 'undefined' and !params[:subject_id].blank? and params[:subject_id] != 'undefined'
        @subject = params[:subject_type].classify.constantize.find(params[:subject_id])
      end      
    end
    
  end
end
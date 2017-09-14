require_dependency "universal_ar/application_controller"

module UniversalAr
  class PicturesController <  UniversalAr::ApplicationController
    
    skip_before_action :validate_scope
    before_action :find_subject
    
    def index
      if !@subject.nil?
        render json: {pictures: @subject.pictures.map{|a| a.to_json}}
      else
        render json: {pictures: []}  
      end
      
    end
    
    def create
      if !@subject.nil?
        pictures = []
        params[:files].each do |file|
          att = @subject.pictures.create image: file, scope: @subject.scope, name: params[:name], user: current_user
          puts att.errors.to_json
          pictures.push(att)
        end
        render json: {pictures: @subject.pictures.map{|a| a.to_json}}
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
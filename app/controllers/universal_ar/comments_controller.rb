require_dependency "universal_ar/application_controller"

module UniversalAr
  class CommentsController < UniversalAr::ApplicationController

    skip_before_action :validate_scope
    before_action :find_model

    def index
      @model = find_model
      render json: comments_json
    end

    def create
      @model = find_model
      @comment = @model.comments.new content: params[:content]
      @comment.scope = @model.scope
      @comment.user = current_user
      if @comment.save
        # @model.touch
      else
        logger.debug @comment.errors.to_json
      end
      render json: comments_json
    end

    def destroy
      @model = find_model
      @comment = @model.comments.find(params[:id])
      @comment&.destroy
      render json: comments_json     
    end

    private
    def find_model
      if params[:subject_type]
        return params[:subject_type].classify.constantize.unscoped.find params[:subject_id]
      end
      return nil
    end

    def comments_json
      @model.comments.map{|c|
        {
          id: c.id.to_s,
          kind: c.kind.to_s,
          author: (c.user.nil? ? c.author : c.user.name),
          content: c.content,
          created_at: c.created_at,
          when_formatted: c.created_at.strftime('%b %d, %Y, %l:%M%P')
        }
      }
    end

  end
end

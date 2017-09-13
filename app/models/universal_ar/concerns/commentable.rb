module UniversalAr::Concerns::Commentable

  extend ActiveSupport::Concern

  included do
    
    has_many :comments, class_name: 'UniversalAr::Comment', as: :subject
    
    def save_comment!(content, user, passed_scope=nil, kind=nil, title=nil)
      comment = self.comments.create  content: content,
                            user: user,
                            scope: (passed_scope.nil? ? self.scope : passed_scope),
                            title: title
      comment.kind = kind if !kind.nil?                            
      return comment
    end

  end
end

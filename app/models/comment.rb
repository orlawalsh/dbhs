class Comment < ActiveRecord::Base
  include Shared::Callbacks
  include ActsAsCommentable::Comment
  include Mention

  belongs_to :commentable, polymorphic: true, counter_cache: true
  default_scope -> { order('created_at DESC') }
  
  belongs_to :user

  include PublicActivity::Model
  tracked only: [:create], owner: proc { |_controller, model| model.user }

  validates_presence_of :comment
  validates_presence_of :commentable
  validates_presence_of :user

  auto_html_for :comment do
    image
    youtube(width: 400, height: 250, autoplay: true)
    link target: '_blank', rel: 'nofollow'
    simple_format
  end
end

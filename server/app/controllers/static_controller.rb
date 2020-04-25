class StaticController < ApplicationController
  def welcome
    @posts = Post.published
  end
end

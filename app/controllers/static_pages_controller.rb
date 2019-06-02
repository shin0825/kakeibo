class StaticPagesController < ApplicationController
  def home
    flash.now[:success] = "success!"
  end
end

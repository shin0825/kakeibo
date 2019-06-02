class StaticPagesController < ApplicationController
  def home
      flash[:success] = "Rootage!"
  end
end

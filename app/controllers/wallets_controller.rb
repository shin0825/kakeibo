class WalletsController < ApplicationController
  def index
    @wallets = Wallet.paginate(page: params[:page])
  end
end

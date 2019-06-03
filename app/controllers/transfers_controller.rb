class TransfersController < ApplicationController
  def new
    @spend = Spend.new()
    @income = Income.new()
  end

  def create
    @spend = Spend.new(spend_params)
    @spend.spend_reason_id = 999
    @spend.save!
    @income = Income.new(income_params)
    @income.income_reason_id = 999
    @income.save!
    flash[:success] = 'OK! 振替できたよ'
    redirect_to new_transfer_path()
  end

  private
  def spend_params
    params.require(:spend).permit(:amount, :wallet_id, :user_id)
  end

  def income_params
    params.require(:income).permit(:amount, :wallet_id, :user_id)
  end
end

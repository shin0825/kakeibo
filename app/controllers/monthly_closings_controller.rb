class MonthlyClosingsController < ApplicationController
  def new
    @spend = Spend.new()
  end

  def create
    @spend = Spend.new(spend_params)
    @spend.spend_reason_id = 900
    @spend.created_at = @spend.created_at.end_of_month
    @spend.save!
    @income = Income.new(spend_params)
    @income.income_reason_id = 900
    @income.amount = @spend.amount
    @income.created_at = @spend.created_at.beginning_of_month.next_month
    @income.save!
    flash[:success] = 'OK! 月次調整できたよ'
    redirect_to new_monthly_closing_path()
  end

  private
  def spend_params
    params.require(:spend).permit(:amount, :wallet_id, :user_id, :created_at)
  end
end

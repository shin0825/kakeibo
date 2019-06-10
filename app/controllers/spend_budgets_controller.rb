class SpendBudgetsController < ApplicationController
  before_action :set_spend_budget, only: [:show, :edit, :update, :destroy]

  def index
    @spend_budgets = SpendBudget.all
  end

  def new
    @spend_budget = SpendBudget.new
  end

  def edit
  end

  def create
    @spend_budget = SpendBudget.new(spend_budget_params)

    if @spend_budget.save
      redirect_to spend_budgets_url, notice: 'Spend budget was successfully created.'
    else
      render :new
    end
  end

  def update
    if @spend_budget.update(spend_budget_params)
      redirect_to spend_budgets_url, notice: 'Spend budget was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @spend_budget.destroy
    redirect_to spend_budgets_url, notice: 'Spend budget was successfully destroyed.'
  end

  private
    def set_spend_budget
      @spend_budget = SpendBudget.find(params[:id])
    end

    def spend_budget_params
      params.require(:spend_budget).permit(:target_date, :amount, :spend_reason_id, :user_id, :memo)
    end
end

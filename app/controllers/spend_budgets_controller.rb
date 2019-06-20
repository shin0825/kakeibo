class SpendBudgetsController < ApplicationController
  before_action :set_spend_budget, only: [:show, :edit, :update, :destroy]

  def index
    @spend_budgets = SpendBudget.all

    @p_targetDate = Time.now
    if (params[:targetDate].present?)
      @p_targetDate = params[:targetDate].to_date
    end

    @budget_summary = get_spend_budget_summary(@p_targetDate)
  end

  def new
    @spend_budget = SpendBudget.new
  end

  def edit
  end

  def create
    @spend_budget = SpendBudget.new(spend_budget_params)

    if @spend_budget.save
      redirect_to spend_budgets_path(targetDate: @spend_budget[:target_date].strftime('%Y-%m-%D')), notice: 'Spend budget was successfully created.'
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

    def get_spend_budget_summary(targetDate)
      return SpendBudget
        .search_target_date_between(targetDate.in_time_zone.all_month.first, targetDate.in_time_zone.all_month.last)
        .joins(:user)
        .joins(:spend_reason)
        .select(:id)
        .select('spend_reasons.name AS reason_name')
        .select('users.name AS user_name')
        .select(:amount)
        .select('spend_budgets.target_date + interval \'9 hours\' AS target_dt')
        .order('spend_budgets.target_date desc')
        .group_by(&:target_dt)
    end
end

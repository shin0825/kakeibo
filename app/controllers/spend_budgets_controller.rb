class SpendBudgetsController < ApplicationController
  before_action :set_spend_budget, only: [:show, :edit, :update, :destroy]

  def index
    @spend_budgets = SpendBudget.all

    @p_targetDate = Time.zone.now
    if (params[:year].present? && params[:month].present?)
      @p_targetDate = Time.zone.local(params[:year], params[:month], 1, 0, 0, 0)
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
      flash[:success] = '予定を立てたからお金を守ろう'
      redirect_to spend_budgets_index_path(:year => (@spend_budget[:target_date]).year, :month => (@spend_budget[:target_date]).month)
    else
      render :new
    end
  end

  def update
    if @spend_budget.update(spend_budget_params)
      flash[:success] = '予定を立て直しました'
      redirect_to spend_budgets_index_path(:year => (@spend_budget[:target_date]).year, :month => (@spend_budget[:target_date]).month)
    else
      render :edit
    end
  end

  def destroy
    @spend_budget.destroy
    flash[:success] = '予定をなんてなかった、いいね？'
    redirect_to spend_budgets_url
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
        .select('spend_budgets.target_date')
        .order('spend_budgets.target_date desc')
    end
end

class IncomesController < ApplicationController
  def index
    @incomes= Income.joins(:user).select('users.id AS user_id', 'users.name AS user_name', 'SUM(amount) AS amount').group('users.id','users.name').order('amount desc')
  end

  def show
    @p_targetDate = Time.now
    if (params[:targetDate].present?)
      @p_targetDate = params[:targetDate].to_date
    end
    @page_type = "incomes"

    @summary = get_income_summary(@p_targetDate)
  end

  private
  def get_income_summary(targetDate)
    summary =  Income.joins(:income_reason)
      .select(
        'income_reasons.id AS reason_id',
        'income_reasons.name AS reason_name',
        'SUM(incomes.amount) AS amount',
        'date(incomes.created_at) AS created_at'
      )
      .where(created_at: targetDate.all_month)
      .group('created_at', 'reason_id', 'reason_name')
      .order('incomes.created_at desc')
      .group_by(&:created_at)
    return summary
  end
end

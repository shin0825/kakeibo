class SpendsController < ApplicationController
  def index
    @spends= Spend.joins(:user).select('users.id AS user_id', 'users.name AS user_name', 'amount').order('amount desc')
  end

  def show
    @p_targetDate = Time.now
    if (params[:targetDate].present?)
      @p_targetDate = params[:targetDate].to_date
    end

    @summary = get_spend_summary(@p_targetDate)
  end

  private
  def get_spend_summary(targetDate)
    summary =  Spend.joins(:spend_reason)
      .select(
        'spend_reasons.id AS reason_id',
        'spend_reasons.name AS reason_name',
        'SUM(spends.amount) AS amount',
        'date(spends.created_at) AS created_at'
      )
      .where(created_at: targetDate.all_month)
      .group('created_at', 'reason_id', 'reason_name')
      .order('spends.created_at desc')
      .group_by(&:created_at)
    return summary
  end
end
